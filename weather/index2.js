#!/usr/bin/env node
// retrieve current weather conditions from open weather service
// this script is differnt from index.js by only writing data to file as it is read on a timer in clock.qml
var req = require('request');
const api = require('./api.json');
const axios = require('axios');
const fs = require('fs')
const weatherIcons = require('./icons.json');

const getWeather = async location => {
	const city = location || 'La Porte, TX USA';
	const url = `http://api.openweathermap.org/data/2.5/weather?q=${city}&units=imperial&appid=${
		api.key
	}`;
    
     //const url = `http://api.openweathermap.org/data/2.5/forecast?id=4704108&units=imperial&appid=${
	//	api.key
	//}`;
	try {
		const response = await axios.get(url);

		if (response.status === 200) {
			try {
				if (response.data.name) {
					return response.data;
				} else {
					const queryError = new Error(`The location ${city} was not found`);
					printError(queryError);
				}
			} catch (error) {
				printError(error);
			}
		} else {
			const statusCodeError = new Error(
				`There was an error getting the message for ${city}(StatusCode ${
					response.status
				})`
			);
			printError(statusCodeError);
		}
	} catch (error) {
		printError(error);
	}
};

if (require.main == module) {
	const argument = process.argv.slice(3).join(' ');

	getWeather(argument).then(val => {
		printWeather(val);
	});
}

function printWeather(weather) {
    
	// let message = `Current Temperature in ${weather.name} is ${
    let message = `${
		Math.round(weather.main.temp)
	}°`;
    function weatherIcon () {
        var iconurl=`` // assign icon code to file
        if (weather.weather[0].icon === '01d') {
        iconurl= `01d.png`} else if (weather.weather[0].icon === '01n') {
            iconurl=`01n.png`}
            else if  (weather.weather[0].icon === '02d') {
            iconurl=`02d.png`}
        else if  (weather.weather[0].icon === '02n') {
            iconurl=`02n.png`}
        else if  (weather.weather[0].icon === '03d') {
            iconurl=`03d.png`}
        else if  (weather.weather[0].icon === '03n') {
            iconurl=`03n.png`}
            else if  (weather.weather[0].icon === '04n') {
            iconurl=`04n.png`}
            else if  (weather.weather[0].icon === '04d') {
            iconurl=`04d.png`}
            else if  (weather.weather[0].icon === '09n') {
            iconurl=`09n.png`}
            else if  (weather.weather[0].icon === '09d') {
            iconurl=`09d.png`}
            else if  (weather.weather[0].icon === '10n') {
            iconurl=`10n.png`}
            else if  (weather.weather[0].icon === '10d') {
            iconurl=`10d.png`}
            else if  (weather.weather[0].icon === '11n') {
            iconurl=`11n.png`}
            else if  (weather.weather[0].icon === '11d') {
            iconurl=`11d.png`}
            else if  (weather.weather[0].icon === '13n') {
            iconurl=`13n.png`}
            else if  (weather.weather[0].icon === '13d') {
            iconurl=`13d.png`}
            else if  (weather.weather[0].icon === '50n') {
            iconurl=`50n.png`}
            else if  (weather.weather[0].icon === '50d') {
            iconurl=`50d.png`}
            else if  (weather.weather[0].icon === 'na') {
            iconurl=`na.png`}
            return iconurl;
        }
       
       if (weather.weather[0].description == "broken clouds") {
           weather.weather[0].description = "partly cloudy"
       }
       if (weather.weather[0].description == "few clouds") {
           weather.weather[0].description = "Mostly Clear"
       }
       if (weather.weather[0].description == "light intensity drizzle") {
           weather.weather[0].description = "drizzly rain"
       }
       if (weather.weather[0].description == "heavy intensity drizzle") {
           weather.weather[0].description = "drizzly rain"
       }
       if (weather.weather[0].description == "light intensity drizzle rain") {
           weather.weather[0].description = "drizzly rain"
       }
       if (weather.weather[0].description == "heavy intensity drizzle rain") {
           weather.weather[0].description = "drizzly rain"
       }
       if (weather.weather[0].description == "heavy shower rain and drizzle") {
           weather.weather[0].description = "drizzly rain"   
       }
       if (weather.weather[0].description == "light intensity shower rain") {
           weather.weather[0].description = "light rain showers"   
       }
       if (weather.weather[0].description == "heavy intensity shower rain") {
           weather.weather[0].description = "heavy rain showers"   
       }
       if (weather.weather[0].description == "ragged shower rain") {
           weather.weather[0].description = "heavy rain showers"   
       }
       if (weather.weather[0].description == "thunderstorm with light rain") {
           weather.weather[0].description = "thunderstorms with light rain"   
       }
       if (weather.weather[0].description == "thunderstorm with drizzle") {
           weather.weather[0].description = "thunderstorms with light drizzle"  
       }
       if (weather.weather[0].description == "ragged thunderstorm") {
           weather.weather[0].description = "heavy thunderstorms"  
       }
       if (weather.weather[0].description == "light thunderstorm") {
           weather.weather[0].description = "light rain thunderstorms"  
       }
       if (weather.weather[0].description == "heavy thunderstorm") {
           weather.weather[0].description = "heavy rain thunderstorms"  
       }
       if (weather.weather[0].description == "thunderstorm with rain") {
           weather.weather[0].description = "light rain thunderstorms"  
       }
       if (weather.weather[0].description == "thunderstorm with heavy rain") {
           weather.weather[0].description = "heavy rain thunderstorms"  
       }
       if (weather.weather[0].description == "thunderstorm") {
           weather.weather[0].description = "thunderstorms"  
       }
       if (weather.weather[0].description == "overcast clouds") {
           weather.weather[0].description = "Mostly Cloudy"  
       }
       if (weather.weather[0].description == "scattered clouds") {
           weather.weather[0].description = "Partly Cloudy"  
       }
       
       console.log(weather)
       
       // setup variables to store weather info
    let t1 = `var temp  = \x22`
                let t2 = `°  `
                let t3 = weather.weather[0].description
                let t4 = Math.round(weather.main.temp)+`°  `
                let t5 = ` `
                let t6 = `\nvar icon =\x22`
                let t7 = `\x22`+weatherIcon ()+`\x22`;
                let t8 = `\x22`
                
        // write data js variables to file system used in clock.qml


fs.writeFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/temp.txt`,t4, function (err) {
  if (err) throw err;
});
fs.writeFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/desc.txt`,t3, function (err) {
  if (err) throw err;
});

fs.writeFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/icon.txt`,t7, function (err) {
  if (err) throw err;
});
    
}
function printError(error) {
	console.error(error.message);
}

module.exports = {
	getWeather,
	printWeather
};
