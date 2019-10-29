#!/usr/bin/env node
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

	// console.log(message);
    // console.log(weather.weather[0].main,Math.round(weather.main.temp));
    // console.log(weather.weather[0].description);
    // console.log(weather.weather[0].icon);
    // console.log(weather.weather[0].id);
    function weatherIcon () {
        var iconurl=``
        if (weather.weather[0].icon === '01d') {
        iconurl= `../icons/01d.png`} else if (weather.weather[0].icon === '01n') {
            iconurl=`../icons/01n.png`}
            else if  (weather.weather[0].icon === '02d') {
            iconurl=`../icons/02d.png`}
        else if  (weather.weather[0].icon === '02n') {
            iconurl=`../icons/02n.png`}
        else if  (weather.weather[0].icon === '03d') {
            iconurl=`../icons/03d.png`}
        else if  (weather.weather[0].icon === '03n') {
            iconurl=`../icons/03n.png`}
            else if  (weather.weather[0].icon === '04n') {
            iconurl=`../icons/04n.png`}
            else if  (weather.weather[0].icon === '04d') {
            iconurl=`../icons/04d.png`}
            else if  (weather.weather[0].icon === '09n') {
            iconurl=`../icons/09n.png`}
            else if  (weather.weather[0].icon === '09d') {
            iconurl=`../icons/09d.png`}
            else if  (weather.weather[0].icon === '10n') {
            iconurl=`../icons/10n.png`}
            else if  (weather.weather[0].icon === '10d') {
            iconurl=`../icons/10d.png`}
            else if  (weather.weather[0].icon === '11n') {
            iconurl=`../icons/11n.png`}
            else if  (weather.weather[0].icon === '11d') {
            iconurl=`../icons/11d.png`}
            else if  (weather.weather[0].icon === '13n') {
            iconurl=`../icons/13n.png`}
            else if  (weather.weather[0].icon === '13d') {
            iconurl=`../icons/13d.png`}
            else if  (weather.weather[0].icon === '50n') {
            iconurl=`../icons/50n.png`}
            else if  (weather.weather[0].icon === '50d') {
            iconurl=`../icons/50d.png`}
            else if  (weather.weather[0].icon === 'na') {
            iconurl=`../icons/na.png`}
            return iconurl;
        }
       
    let t1 = `var temp  = \x22 `
                let t2 = `° `
                let t3 = weather.weather[0].description
                let t4 = Math.round(weather.main.temp)
                let t5 = ` -  `
                let t6 = `\nvar icon =\x22`
                let t7 = weatherIcon ();
                let t8 = `\x22`
                
fs.writeFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/temp.js`,t1, function (err) {
  if (err) throw err;
});
    fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/temp.js`,t4, function (err) {
  if (err) throw err;
});      
    fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/temp.js`,t2,
                function (err) {
  if (err) throw err;
});
    fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/temp.js`,t5, function (err) {
  if (err) throw err;
});    
    fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/temp.js`,t3, function (err) {
  if (err) throw err;
});
fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/temp.js`,t8,
                function (err) {
  if (err) throw err;
});
        fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/temp.js`,t6, function (err) {
  if (err) throw err;
});    
        fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/temp.js`,t7, function (err) {
  if (err) throw err;
});    
        fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/temp.js`,t8, function (err) {
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
