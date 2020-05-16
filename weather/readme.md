### Weather scripts used to display current conditions and forecast

copy index.js to nodejs-weather-app-master folder backup orginal index.js </br>
  ** modified to write data to a file used within clock.qml for current weather temp and conditions </br>
modify this line in index.js to relect directory of theme if different </br>
  fs.writeFileSync(`$HOME/.local/share/plasma/look-and-feel/MyBreeze/contents/code/temp.txt`,t1, function (err) { </br>
  
  
copy forecast.js to node-weather-forecast-command-line-master/ folder backup orginal forecast.js </br>
** modified to write data to a file used within clock.qml for 5 day weather forecast </br>
modify this line in forecast.js to relect directory of theme if different </br>
  fs.writeFileSync(`$HOME/.local/share/plasma/look-and-feel/MyBreeze/contents/code/forecast.js`,t1, function (err) { </br>
