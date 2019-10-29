'use strict';
// function nat_day() {
const ical = require('ical');
const fs = require('fs')
var dt = new Date();
var m = dt.getMonth()+1;
var day = dt.getDate();
const today = `${m}${day}`
// const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
// ical.fromURL('https://calendar.google.com/calendar/ical/9u8jqp3hlt6pe675gie6lf1d9o%40group.calendar.google.com/public/basic.ics', {}, function (err, data) {
    // ical.parseFile('/run/media/hammer/Data/projects/natday.ics', {}, function (err, data) {
    var data = ical.parseFile('/run/media/hammer/Data/projects/myical.ics');
	for (let d  in data) {
		if (data.hasOwnProperty(d)) {
			var ev = data[d];
            // console.log(ev.summary);
			if (data[d].type == 'VEVENT') {
            if (`${data[d].start.getMonth()+1}${data[d].start.getDate()}` == today) {    
                // console.log(ev.summary)
               //  txtFile.writeln(output);
                let t1 = `var today  = \x22`
                let t2 = `\x22`
                
                fs.writeFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/natday.js`,t1, function (err) {
  if (err) throw err;
});
                fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/natday.js`,ev.summary, function (err) {
  if (err) throw err;
});
                
                fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/natday.js`,t2,
                function (err) {
  if (err) throw err;
});
                
                
                return ev.summary;
                // document.writeln(today,ev.summary);
                // console.log(today)
                // console.log(`${data[d].start.getMonth()+1}/${data[d].start.getDate()} - ${data[d].summary}`);
           
                
            }
            
                
            }
		
            
        }
		
		
	
        
    }
	
// });

