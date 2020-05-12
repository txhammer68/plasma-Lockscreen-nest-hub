// js node forecast.js retrieve weather forecast for next 5 days weather.com
// modified weather forecast js to write forecast data to js files used in clock.qml
// api documentation https://weather.com/swagger-docs/call-for-code

const fs = require('fs')
var https     = require('https');
// var apiFile  = require('./apiFile'); // apiKey in separate apiFile.js file to protect it :)
var zip = `77571`

var dow = [{day: ``,maxtemp: 0,mintemp: 0,rain: 0,icon: ``},{day: ``,maxtemp: 0,mintemp: 0,rain: 0,icon: ``},{day: ``,maxtemp: 0,mintemp: 0,rain: 0,icon: ``},{day: ``,maxtemp: 0,mintemp: 0,rain: 0,icon: ``},{day: ``,maxtemp: 0,mintemp: 0,rain: 0,icon: ``},{day: ``,maxtemp: 0,mintemp: 0,rain: 0,icon: ``},{day: ``,maxtemp: 0,mintemp: 0,rain: 0,icon: ``}]
//setup array for daily forecast

var rain = 0;
var icon = ``;
var maxtemp = 0;
var mintemp = 0;
var i = 0
var summary = "";
       
// function to print out the weather
function printWeather(forecast) {
  var message = 'Your weather forcast is: ' + forecast;
  console.log(message);
};

// function to print out errors
function printError(error) {
  console.error(error.message);
  if (error.message === "Cannot read property 'txt_forecast' of undefined") {
    console.log('Try entering a real 5-digit zip!');
  };
};

function getForecast() {
  var request = https.get(`https://api.weather.com/v3/wx/forecast/daily/5day?postalKey=77571:US&units=e&language=en-US&format=json&apiKey=your key here`, function(response) {
    // console.log(response.statusCode); // for testing to see the status code
    var body = ''; // start with an empty body since node gets responses in chunks

    // Read the data
    response.on('data', function(chunk) {
      body += chunk;
    });

    response.on('end', function() {
      if ( response.statusCode === 200 ) {
        try {
          // Parse the data
          var forecast = JSON.parse(body);
         // summary = `var summary = ` + `\x22`+forecast.narrative[0]+`\x22`; // current conditions  
          summary = forecast.narrative[0]; // current conditions  
          // summary.innerText = summary.innerText.replace(/[^\s]./, '')
           // summary=summary.string.substring(start, end)
           // summary = summary.replace(/^.\s/i, " ");
           // summary=summary.split(".", 2)
           summary = summary.substring(summary.indexOf('.')+1);
           //console.log(summary)
            
          for (i = 0; i <= 5  ; i++) { //iterate thru the forecast data for each day
               
        if (forecast.dayOfWeek[i] == `Monday`) { //for each day assign forecast data
            icon = forecast.daypart[0].iconCode[i*2] 
            rain = forecast.daypart[0].precipChance[i*2];
            dow[i].day = `\nvar day` + i + `=\x22MON\x22`
            dow[i].maxtemp = `\nvar maxtemp` + i + `=\x22`+forecast.temperatureMax[i]+`°`+`\x22`
            dow[i].mintemp = `\nvar mintemp`  + i + `=\x22` + forecast.temperatureMin[i-1]+`°`+`\x22`
            dow[i].rain = `\nvar rain` + i + `=\x22` + rain+`%`+`\x22`
            dow[i].icon = `\nvar icon` + i +`=\x22` + weatherIcon (icon) +`\x22`
        }
        
        else if  (forecast.dayOfWeek[i] == `Tuesday`) {

            icon = forecast.daypart[0].iconCode[i*2]
            rain = forecast.daypart[0].precipChance[i*2];
            dow[i].day = `\nvar day` + i + `=\x22TUE\x22`
            dow[i].maxtemp = `\nvar maxtemp` + i + `=\x22`+forecast.temperatureMax[i]+`°`+`\x22`
            dow[i].mintemp = `\nvar mintemp`  + i + `=\x22` + forecast.temperatureMin[i-1]+`°`+`\x22`
            dow[i].rain = `\nvar rain` + i + `=\x22` + rain+`%`+`\x22`
            dow[i].icon = `\nvar icon` + i + `=\x22` + weatherIcon (icon) +`\x22`
        }  
        
        else if  (forecast.dayOfWeek[i] == `Wednesday`) {
            icon = forecast.daypart[0].iconCode[i*2]
            rain = forecast.daypart[0].precipChance[i*2];
            dow[i].day = `\nvar day` + i + `= \x22WED\x22`
            dow[i].maxtemp = `\nvar maxtemp` + i + `=\x22`+forecast.temperatureMax[i]+`°`+`\x22`
            dow[i].mintemp = `\nvar mintemp` + i + `=\x22` + forecast.temperatureMin[i-1]+`°`+`\x22`
            dow[i].rain = `\nvar rain` + i + `=\x22` + rain+`%`+`\x22`
            dow[i].icon = `\nvar icon` + i + `=\x22` + weatherIcon (icon) +`\x22`
        } 
         
        else if  (forecast.dayOfWeek[i] == `Thursday`) {
    
            icon = forecast.daypart[0].iconCode[i*2]
            rain = forecast.daypart[0].precipChance[i*2];
            dow[i].day = `\nvar day` + i + `= \x22THU\x22`
            dow[i].maxtemp = `\nvar maxtemp` + i + `=\x22`+forecast.temperatureMax[i]+`°`+`\x22`
            dow[i].mintemp = `\nvar mintemp` + i + `=\x22` + forecast.temperatureMin[i-1]+`°`+`\x22`
            dow[i].rain = `\nvar rain` + i + `=\x22` + rain+`%`+`\x22`
            dow[i].icon = `\nvar icon` + i + `=\x22` + weatherIcon (icon) +`\x22`
        } 
        else if  (forecast.dayOfWeek[i] == `Friday`) {
            icon = forecast.daypart[0].iconCode[i*2]
            rain = forecast.daypart[0].precipChance[i*2];
            dow[i].day = `\nvar day` + i + `= \x22FRI\x22`
            dow[i].maxtemp = `\nvar maxtemp` + i + `=\x22`+forecast.temperatureMax[i]+`°`+`\x22`
            dow[i].mintemp = `\nvar mintemp` + i + `=\x22` + forecast.temperatureMin[i-1]+`°`+`\x22`
            dow[i].rain = `\nvar rain` + i + `=\x22` + rain+`%`+`\x22`
            dow[i].icon = `\nvar icon` + i + `=\x22` + weatherIcon (icon) +`\x22`
        }
        else if  (forecast.dayOfWeek[i] == `Saturday`) {
            icon = forecast.daypart[0].iconCode[i*2]
            rain = forecast.daypart[0].precipChance[i*2];
            dow[i].day = `\nvar day` + i + `=\x22SAT\x22`
            dow[i].maxtemp = `\nvar maxtemp` + i + `=\x22`+forecast.temperatureMax[i]+`°`+`\x22`
            dow[i].mintemp = `\nvar mintemp` + i + `=\x22` + forecast.temperatureMin[i-1]+`°`+`\x22`
            dow[i].rain = `\nvar rain` + i + `=\x22` + rain+`%`+`\x22`
            dow[i].icon = `\nvar icon` + i + `=\x22` + weatherIcon (icon) +`\x22`
        }
        else if  (forecast.dayOfWeek[i] == `Sunday`) {
            icon = forecast.daypart[0].iconCode[i*2]
            rain = forecast.daypart[0].precipChance[i*2];
            dow[i].day = `\nvar day` + i + `= \x22SUN\x22`
            dow[i].maxtemp = `\nvar maxtemp` + i + `=\x22`+forecast.temperatureMax[i]+`°`+`\x22`
            dow[i].mintemp = `\nvar mintemp` + i + `=\x22` + forecast.temperatureMin[i-1]+`°`+`\x22`
            dow[i].rain = `\nvar rain` + i + `=\x22` + rain+`%`+`\x22`
            dow[i].icon = `\nvar icon` + i + `=\x22` + weatherIcon (icon) +`\x22`
        }
   }   // end for loop

       function weatherIcon (icon) {  //assign icon url from icon code
        var iconurl=``
        if (icon == 00) {
        iconurl = `../icons/00.png`} 
        else if (icon == 01) {
            iconurl=`../icons/01.png`}
            else if  (icon == 02) {
            iconurl=`../icons/02.png`}
        else if  (icon == 03) {
            iconurl=`../icons/03.png`}
        else if  (icon == 04) {
            iconurl=`../icons/04.png`}
        else if  (icon == 05) {
            iconurl=`../icons/05.png`}
            else if  (icon == 06) {
            iconurl=`../icons/06.png`}
            else if  (icon == 07) {
            iconurl=`../icons/07.png`}
            else if  (icon == 08) {
            iconurl=`../icons/08.png`}
            else if  (icon == 09) {
            iconurl=`../icons/09.png`}
            else if  (icon == 10) {
            iconurl=`../icons/10.png`}
            else if  (icon == 11) {
            iconurl=`../icons/11.png`}
            else if  (icon == 12) {
            iconurl=`../icons/12.png`}
            else if  (icon == 13) {
            iconurl=`../icons/13.png`}
            else if  (icon == 14) {
            iconurl=`../icons/14.png`}
            else if  (icon == 15) {
            iconurl=`../icons/15.png`}
            else if  (icon == 16) {
            iconurl=`../icons/16.png`}
            else if  (icon == 17) {
            iconurl=`../icons/17.png`}
            else if  (icon == 18) {
            iconurl=`../icons/18.png`}
            else if  (icon == 19) {
            iconurl=`../icons/19.png`}
            else if  (icon == 20) {
            iconurl=`../icons/20.png`}
            else if  (icon == 21) {
            iconurl=`../icons/21.png`}
            else if  (icon == 22) {
            iconurl=`../icons/22.png`}
            else if  (icon == 23) {
            iconurl=`../icons/23.png`}
            else if  (icon == 24) {
            iconurl=`../icons/24.png`}
            else if  (icon == 25) {
            iconurl=`../icons/25.png`}
            else if  (icon == 26) {
            iconurl=`../icons/26.png`}
            else if  (icon == 27) {
            iconurl=`../icons/27.png`}
            else if  (icon == 28) {
            iconurl=`../icons/28.png`}
            else if  (icon == 29) {
            iconurl=`../icons/29.png`}
            else if  (icon == 30) {
            iconurl=`../icons/30.png`}
            else if  (icon == 31) {
            iconurl=`../icons/31.png`}
            else if  (icon == 32) {
            iconurl=`../icons/32.png`}
            else if  (icon == 33) {
            iconurl=`../icons/33.png`}
            else if  (icon == 34) {
            iconurl=`../icons/34.png`}
            else if  (icon == 35) {
            iconurl=`../icons/35.png`}
            else if  (icon == 36) {
            iconurl=`../icons/36.png`}
            else if  (icon == 37) {
            iconurl=`../icons/37.png`}
            else if  (icon == 38) {
            iconurl=`../icons/38.png`}
            else if  (icon == 39) {
            iconurl=`../icons/39.png`}
            else if  (icon == 40) {
            iconurl=`../icons/40.png`}
            else if  (icon == 41) {
            iconurl=`../icons/41.png`}
            else if  (icon == 42) {
            iconurl=`../icons/42.png`}
            else if  (icon == 43) {
            iconurl=`../icons/43.png`}
            else if  (icon == 44) {
            iconurl=`../icons/44.png`}
            else if  (icon == 45) {
            iconurl=`../icons/45.png`}
            else if  (icon == 46) {
            iconurl=`../icons/46.png`}
            else if  (icon == 47) {
            iconurl=`../icons/47.png`}            
            else if  (icon == 'na') {
            iconurl=`../icons/na.png`}
            return iconurl;
        }        
        
    var fd = fs.openSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/forecast.txt`, "w");
    var fd1 = fs.openSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/forecast.js`, "w");
    
        fs.writeFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/forecast.txt`,summary, function (err) {
  if (err) throw err;
});   // current conditions
        
        fs.writeFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/forecast.js`,"", function (err) {
  if (err) throw err;
});   // current conditio
        
        // write forcast data to qml js variables // skip [0] as it is current day
        for (i = 1; i <= 5 ; i++) { 
   
         fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/forecast.js`,(dow[i].day), function (err) {
  if (err) throw err;
});
         fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/forecast.js`,(dow[i].mintemp), function (err) {
  if (err) throw err;
});    
             fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/forecast.js`,(dow[i].maxtemp), function (err) {
  if (err) throw err;
});    
             fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/forecast.js`,(dow[i].rain), function (err) {
  if (err) throw err;
});    
              fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/forecast.js`,(dow[i].icon), function (err) {
  if (err) throw err;
});
}

fs.closeSync( fd );
fs.closeSync( fd1 );

          // Print the data
          // printWeather(forecast.forecast.txt_forecast.forecastday[0].fcttext);
        } catch(error) {
          // Print any errors
          printError(error);
        };

      } else {
        // Status code error
        printError({message: 'OOPS! There was a problem getting the weather! (' + response.statusCode + ')'});
      };
    });
  });

  // Print connection error
  request.on('error', printError);

// end getForecast function
};

// uncomment below if you want to run this file from the command line. ex: node forecast.js 28285
getForecast(process.argv); // process.argv lets you pass a zip in command line. ex: node forecast.js 28285

// uncomment below if you want to run this forecast  from a separate file. ex: node app.js 28285
// module.exports.getForecast = getForecast;
