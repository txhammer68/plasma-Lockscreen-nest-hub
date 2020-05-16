### JS files to get ical info
install ical, fs with npm install ical, npm install fs
change nat-day1.js for location you web cal or ics file
within nat-day1.js change below to your directory if different
fs.writeFileSync(`$HOME/.local/share/plasma/look-and-feel/MyBreeze/contents/code/natday.js`,t1, function (err) {
