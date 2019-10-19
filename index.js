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

	console.log(message);
    // console.log(weather.,Math.round(weather.main.temp));
    // console.log(weather);
    let t1 = `var temp  = \x22`
                let t2 = `°\x22`
                let t3 = (Math.round(weather.main.temp))
    fs.writeFile(`/run/media/hammer/Data/projects/temp.js`,t1, function (err) {
  if (err) throw err;
});
                fs.appendFile(`/run/media/hammer/Data/projects/temp.js`,t3, function (err) {
  if (err) throw err;
});
                
                fs.appendFile(`/run/media/hammer/Data/projects/temp.js`,t2,
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
