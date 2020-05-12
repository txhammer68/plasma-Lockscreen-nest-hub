#!/usr/bin/env node
// retrieve current weather conditions from open weather service
// this script is differnt from index.js by only writing data to file as it is read on a timer in clock.qml
var req = require('request');
const api = require('./api.json');
const axios = require('axios');
const fs = require('fs')
const weatherIcons = require('./icons.json');

const getWeather = async location => {
    const url = `https://api.openweathermap.org/data/2.5/weather?lat=29.669375&lon=-95.064289&units=imperial&appid=${api.key}`;
	
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
        var iconurl="" // assign icon code to file
        if (weather.weather[0].icon === "01d") {
        iconurl= "../icons/01d.png"} else if (weather.weather[0].icon === '01n') {
            iconurl="../icons/01n.png"}
            else if  (weather.weather[0].icon === '02d') {
            iconurl="../icons/02d.png"}
        else if  (weather.weather[0].icon === '02n') {
            iconurl="../icons/02n.png"}
        else if  (weather.weather[0].icon === '03d') {
            iconurl="../icons/03d.png"}
        else if  (weather.weather[0].icon === '03n') {
            iconurl="../icons/03n.png"}
            else if  (weather.weather[0].icon === '04n') {
            iconurl="../icons/04n.png"}
            else if  (weather.weather[0].icon === '04d') {
            iconurl="../icons/04d.png"}
            else if  (weather.weather[0].icon === '09n') {
            iconurl="../icons/09n.png"}
            else if  (weather.weather[0].icon === '09d') {
            iconurl="../icons/09d.png"}
            else if  (weather.weather[0].icon === '10n') {
            iconurl="../icons/10n.png"}
            else if  (weather.weather[0].icon === '10d') {
            iconurl="../icons/10d.png"}
            else if  (weather.weather[0].icon === '11n') {
            iconurl="../icons/11n.png"}
            else if  (weather.weather[0].icon === '11d') {
            iconurl="../icons/11d.png"}
            else if  (weather.weather[0].icon === '13n') {
            iconurl="../icons/13n.png"}
            else if  (weather.weather[0].icon === '13d') {
            iconurl="../icons/13d.png"}
            else if  (weather.weather[0].icon === '50n') {
            iconurl="../icons/50n.png"}
            else if  (weather.weather[0].icon === "50d") {
            iconurl="../icons/50d.png"}
            else if  (weather.weather[0].icon === 'na') {
            iconurl="../icons/na.png"}
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
       if (weather.weather[0].description == "haze") {
           weather.weather[0].description = "Hazey"  
       }
       
       // console.log(weather)
       
       // setup variables to store weather info
       let t1 = Math.round(weather.main.temp)+`°  `         
       let t2 = weather.weather[0].description
       let t3 = weatherIcon ();
                
        // write data to js variables on file system used in clock.qml
       
var fd = fs.openSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/temp.txt`, "w");

fs.writeFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/temp.txt`,t1, function (err) {
  if (err) throw err;
});
fs.writeFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/desc.txt`,t2, function (err) {
  if (err) throw err;
});

fs.writeFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/icon.txt`,t3, function (err) {
  if (err) throw err;
});

fs.closeSync( fd );
    
}
function printError(error) {
	console.error(error.message);
}

module.exports = {
	getWeather,
	printWeather
};
