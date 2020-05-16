'use strict';
const ical = require('ical');
const fs = require('fs')
var dt = new Date();
var m = dt.getMonth()+1;
var day = dt.getDate();

if (day < 10) {//if less then 10 add a leading zero
     day = "0" + day;
   }
 if (m < 10) {
    m = "0" + m;//if less then 10 add a leading zero
  }

const today = `${m}${day}`
 
    var data = ical.parseFile('$HOME/projects/calendar/myical.ics');
	for (let d  in data) {
		if (data.hasOwnProperty(d)) {
			var ev = data[d];
			if (data[d].type == 'VEVENT') {
                var m1 = data[d].start.getMonth()+1
                var d1 = data[d].start.getDate()
                
                if (d1 < 10) {           //if less then 10 add a leading zero
                    d1 = "0" + d1;
                    }
                if (m1 < 10) {
                m1 = "0"+m1;            //if less then 10 add a leading zero
                }
                 
                if (`${m1}${d1}` == today) { 
                let t1 = `var today  = \x22`
                let t2 = `\x22`
                // console.log(today,ev.summary);
               //console.log(`${m1}${d1}`)
                
                fs.writeFileSync(`$HOME/.local/share/plasma/look-and-feel/MyBreeze/contents/code/natday.js`,t1, function (err) {
  if (err) throw err;
});
                fs.appendFileSync(`$HOME/.local/share/plasma/look-and-feel/MyBreeze/contents/code/natday.js`,ev.summary, function (err) {
  if (err) throw err;
});
                
                fs.appendFileSync(`$HOME/.local/share/plasma/look-and-feel/MyBreeze/contents/code/natday.js`,t2,
                function (err) {
  if (err) throw err;
});
                
                
                return ev.summary;
                // document.writeln(today,ev.summary);
                // console.log(today)
               
           
                
            }
            
            else {                  // no event today set to blank to erase yesterdays event
               // console.log(today,m1,d1);
                let t1 = `var today  = \x22`
                let t2 = `\x22`
                // console.log(ev.summary)
                 // console.log(ev.summary)
                 // console.log(today,ev.summary);
                //  console.log(today,m1,d1); // no event today
                ev.summary=""
                fs.writeFileSync(`$HOME/.local/share/plasma/look-and-feel/MyBreeze/contents/code/natday.js`,t1, function (err) {
  if (err) throw err;
});
                fs.appendFileSync(`$HOME/.local/share/plasma/look-and-feel/MyBreeze/contents/code/natday.js`,ev.summary, function (err) {
  if (err) throw err;
});
                
                fs.appendFileSync(`$HOME/.local/share/plasma/look-and-feel/MyBreeze/contents/code/natday.js`,t2,
                function (err) {
  if (err) throw err;
});
            }
            
                
            }
		
            
        }
		
		
	
        
    }
	
// });

