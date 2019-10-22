#!/usr/bin/env node
const api = require('./api.json');
const axios = require('axios');
const fs = require('fs')

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
    // console.log(weather.weather[0].main);
    // console.log(weather);
    
    let t1 = `var temp  = \x22 `
                let t2 = `°\x22`
                let t3 = weather.weather[0].main
                let t4 = Math.round(weather.main.temp)
                let t5 = ` - `
                // console.log(t3);
    fs.writeFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/temp.js`,t1, function (err) {
  if (err) throw err;
});
    fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/temp.js`,t3, function (err) {
  if (err) throw err;
});      
    fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/temp.js`,t5, function (err) {
  if (err) throw err;
});    
    
    fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/temp.js`,t4, function (err) {
  if (err) throw err;
});
                
                fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/temp.js`,t2,
                function (err) {
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
