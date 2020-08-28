/*
 *   Copyright 2016 David Edmundson <davidedmundson@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2 or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU Library General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

// custom clock for plasma lockscreen
// shows weather,email,stocks
// /usr/lib/kscreenlocker_greet --testing --theme $HOME/.local/share/plasma/look-and-feel/DigiTech

import QtQuick 2.9
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.5
import org.kde.plasma.core 2.0
import "../code/market.js" as Market
import "../code/forecast.js" as Forecast

ColumnLayout {
    spacing : 20
    Layout.preferredWidth : 600
    property var font_color:"white"         // change font color
    property var font_style1:"Noto Serif"   // change clock font
    property var font_style2:"Noto Sans"    // change info status font
    property date currentDate: new Date()
    property var yesterday:(Qt.formatDate(currentDate, "MMd"))
    property var dow_color: Market.dow_up ? "green" : "red"
    property var nasdaq_color: Market.nasdaq_up ? "green" : "red"
    property var sp500_color: Market.sp500_up ? "green" : "red"
    property var oil_color: Market.oil_up ? "green" : "red"
    property var gold_color: Market.gold_up ? "green" : "red"
    property var y10_color: Market.y10_up ? "green" : "red"
    property var dow_symbol: Market.dow_up ? "▲ " : "▼ "
    property var nasdaq_symbol: Market.nasdaq_up ? "▲ " : "▼ "
    property var sp500_symbol: Market.sp500_up ? "▲ " : "▼ "
    property var oil_symbol: Market.oil_up ? "▲ " : "▼ "
    property var gold_symbol: Market.gold_up ? "▲ " : "▼ "
    property var y10_symbol: Market.y10_up ? "▲ " : "▼ "
    Component.onCompleted: {
        readWeatherFile("/home/matt/.local/share/plasma/look-and-feel/DigiTech/contents/code/weather.json")
        //readForecastFile("/home/matt/.local/share/plasma/look-and-feel/DigiTech/contents/code/forecast.txt")
        readEventFile("/home/matt/.local/share/plasma/look-and-feel/DigiTech/contents/code/event.txt")
        readEmailFile("/home/matt/.local/share/plasma/look-and-feel/DigiTech/contents/code/gmail.txt")
    }
    
Item {
id: root // timer for suspend-resume update
property double startTime: 0
property int secondsElapsed: 0
function restartCounter() {
root.startTime = 0;
}
function timeChanged() {
if(root.startTime==0)
{
root.startTime = new Date().getTime(); //returns the number of milliseconds since the epoch (1970-01-01T00:00:00Z);
}
var currentTime = new Date().getTime();
root.secondsElapsed = (currentTime-startTime)/1000;
}
}
    
    function isDateChanged() {   // update events after midnight
                var today = Qt.formatDate(timeSource.data["Local"]["DateTime"],"MMd")
                if (yesterday != today) {
                readEventFile("/home/matt/.local/share/plasma/look-and-feel/DigiTech/contents/code/event.txt")
                }
                return 0
    }
    
   function readEmailFile(fileUrl){  // read icon code from file
       var xhr = new XMLHttpRequest;
       xhr.open("GET", fileUrl); // set Method and File
       xhr.onreadystatechange = function () {
           if(xhr.readyState === XMLHttpRequest.DONE){ // if request_status == DONE
               var response = xhr.responseText;
               email_count.email  = response;
           }
       }
       xhr.send(); // begin the request
       return 0
   }
    
    function readWeatherFile(fileUrl){  // read weather icon code from file
       var xhr = new XMLHttpRequest;
       xhr.open("GET", fileUrl); // set Method and File
       xhr.onreadystatechange = function () {
           if(xhr.readyState === XMLHttpRequest.DONE){ // if request_status == DONE
               var response = xhr.responseText;
               var data = JSON.parse(response);
               current_weather_conditions.temp = data.temp;
               current_weather_conditions.forecast = data.forecast;
               wIcon.wIconurl  = data.icon;
               
           }
       }
       xhr.send(); // begin the request
       return 0
   }
    
    function readEventFile(fileUrl){  // read weather icon code from file
       var xhr = new XMLHttpRequest;
       xhr.open("GET", fileUrl); // set Method and File
       xhr.onreadystatechange = function () {
           if(xhr.readyState === XMLHttpRequest.DONE){ // if request_status == DONE
               var response = xhr.responseText;
               calEvents.desc = response
           }
       }
       xhr.send(); // begin the request
       return 0
   }

    Label {
        id:time
        topPadding : 70
        text: Qt.formatTime(timeSource.data["Local"]["DateTime"],"h:mm ap").replace("am", "").replace("pm", "")
                                                                            // removes am,pm
        color: font_color
        antialiasing : true
        Layout.alignment: Qt.AlignHCenter
        renderType: Text.QtRendering
        font {
            pointSize: 72
            family: font_style1
        }
    }
    Label {
        id:date
        function getOrdinal(n) {            // assigns superfix to date
        var s=["th","st","nd","rd"],
        v=n%100;
        return (s[(v-20)%10]||s[v]||s[0]);
        }
        property var nth:getOrdinal(Qt.formatDate(timeSource.data["Local"]["DateTime"],"d"))
        // text: Qt.formatDate(timeSource.data["Local"]["DateTime"], Qt.DefaultLocaleLongDate)
        textFormat: Text.RichText
        text: Qt.formatDate(timeSource.data["Local"]["DateTime"],"dddd - MMMM  d")+"<sup>"+nth+"</sup>"
                                                                                // html markup for superfix date
        color: font_color
        antialiasing : true
        anchors.top:time.bottom
        Layout.alignment: Qt.AlignHCenter
        renderType: Text.QtRendering
        font {
            pointSize: 28
            family: font_style1
        }
    }
    
    Text {
        id:calEvents
        topPadding:20
        property var desc:""
        text: desc
        Layout.preferredWidth : 600
        Layout.fillWidth : false
        anchors.top:date.bottom
        horizontalAlignment: Text.AlignHCenter
        textFormat: Text.RichText
        color: font_color
        antialiasing : true
        Layout.alignment: Qt.AlignHCenter
        wrapMode:Text.WordWrap
        renderType: Text.QtRendering
        font {
            pointSize: 24 
            // family: config.displayFont
            family: "Ink Free"
            // italic:true
            bold:true
            }        
        }
        
        ToolSeparator {
            id:ts
            anchors.top:calEvents.bottom
            orientation:Qt.Horizontal
            Layout.fillWidth: true
            contentItem: Rectangle {
                implicitWidth: 400
                implicitHeight: 2
                color: "gray"
                antialiasing : true
            }
        }
        
Label {
    id: info 
    Layout.preferredWidth :620
    anchors.top:ts.bottom
    anchors.left:ts.left
      
     Image {
       id: wIcon
       anchors.topMargin: 5
       anchors.top:ts.bottom
       anchors.left:ts.left
       property var wIconurl:""
       asynchronous : true
       cache: false
       source: wIconurl
       smooth: true
       sourceSize.width: 64
       sourceSize.height: 64
    }

        Text {
        id:current_weather_conditions
        Layout.fillWidth: false
        width:calEvents.width *1.2
        anchors.topMargin:5
        anchors.top:wIcon.top
        anchors.left:wIcon.right
        property var temp:""
        property var desc:""
        property var forecast:""
        text:"      "+temp+"          "+forecast        
        font.family: font_style2
        font.pointSize: 18
        font.capitalization: Font.Capitalize
        textFormat: Text.RichText
        color: font_color
        antialiasing : true
        renderType: Text.QtRendering
        
        Timer{                  // timer to trigger update for weather info
        id: readFiles
        interval: 21* 60 * 1000 // every 20 minutes
        running: true
        repeat:  true
        onTriggered: {
            root.startTime=0
            readWeatherFile("/home/matt/.local/share/plasma/look-and-feel/DigiTech/contents/code/weather.json")
            readEmailFile("/home/matt/.local/share/plasma/look-and-feel/DigiTech/contents/code/gmail.txt")
        }
  }
}

Timer{                  // timer to trigger update after wake from suspend mode
       id: suspend
       interval: 1000 ///delay 20 secs for suspend to resume
       running: true
       repeat:  true
       onTriggered: {
                root.timeChanged()
               if (root.secondsElapsed > 1261) {
                readWeatherFile("/home/matt/.local/share/plasma/look-and-feel/DigiTech/contents/code/weather.json")
                readEmailFile("/home/matt/.local/share/plasma/look-and-feel/DigiTech/contents/code/gmail.txt")
                readEventFile("/home/matt/.local/share/plasma/look-and-feel/DigiTech/contents/code/event.txt")
        }
     }   
}
        
    Image {
        id:email_icon
        anchors.topMargin: 5
        anchors.top:wIcon.top
        anchors.left:info.right
        source: "../icons/email3.png"
        // source: "//usr/share/icons/breeze-dark/actions/24/gnumeric-link-email.svg"
        smooth: true
        sourceSize.width: 48
        sourceSize.height: 48
        }
        
        
      
      Text {
        id:bubble
        anchors.topMargin: -15
        anchors.leftMargin:-5
        anchors.top:email_icon.top
        anchors.left:email_icon.right
        text: "🔴"
        font.family: font_style2
        font.pointSize:22
        color: font_color
        antialiasing : true
        renderType: Text.QtRendering
    }
      
      Text {
        id:email_count
        //anchors.topMargin: 5
        //anchors.leftMargin:5
        anchors.horizontalCenter:bubble.horizontalCenter;
        //anchors.top:bubble.top
        //anchors.left:bubble.left
        property var email:""
        text: email
        font.family: font_style2
        font.pointSize:12
        color: font_color
        antialiasing : true
        renderType: Text.QtRendering
    }
}
Label {
     id: info2
     opacity: 0
     Layout.preferredWidth :700
     Layout.alignment:Qt.AlignHCenter
     anchors.top:ts.bottom
     anchors.left:ts.left
     anchors.topMargin:-20

     Grid {
        columns: 5
        columnSpacing :200
        anchors.top:info2.bottom
        anchors.left:info2.left
        anchors.leftMargin:30
        Text {id:d1;text:"  "+Forecast.day1;width:120;font.bold:true;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
        Image {
            id:im1;
            anchors.left:d1.left
            anchors.top:d1.bottom
            anchors.topMargin: 5
            source : Forecast.icon1
            smooth: true
            sourceSize.width: 64
            sourceSize.height: 64
        }
        Text {id:d2;width:140; leftPadding:45;anchors.left:d1.right;font.bold:true;text: Forecast.day2;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
        Image {
        id:im2;
        anchors.top:d2.bottom
        anchors.topMargin: 5
        anchors.horizontalCenter:d2.horizontalCenter
        source : Forecast.icon2
        smooth: true
        sourceSize.width: 64
        sourceSize.height: 64
        }
        Text {id:d3;width:140; leftPadding:45;anchors.left:d2.right;font.bold:true;text: Forecast.day3;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
        Image {
        id:im3;
        anchors.horizontalCenter:d3.horizontalCenter
        anchors.top:d3.bottom
        anchors.topMargin: 5
        source :Forecast.icon3
        smooth: true
        sourceSize.width: 64
        sourceSize.height: 64
        }
        Text {id:d4;width:140; leftPadding:45;anchors.left:d3.right;font.bold:true;text: Forecast.day4;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
        Image {
        id:im4;
        anchors.top:d4.bottom
        anchors.topMargin: 5
        anchors.horizontalCenter:d4.horizontalCenter
        source : Forecast.icon4
        smooth: true
        sourceSize.width: 64
        sourceSize.height: 64
        }
        Text {id:d5;width:140; leftPadding:45;anchors.left:d4.right;font.bold:true;text: Forecast.day5;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
        Image {
        id:im5;
        anchors.top:d5.bottom
        anchors.topMargin: 5
        anchors.horizontalCenter:d5.horizontalCenter
        source :Forecast.icon5
        smooth: true
        sourceSize.width: 64
        sourceSize.height: 64
        }
        Text { id:r1;text: Forecast.rain1;anchors.top:im1.bottom;anchors.horizontalCenter:im1.horizontalCenter;topPadding:5;bottomPadding:5;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
        Text { id:r2;text: Forecast.rain2;anchors.top:im2.bottom;anchors.horizontalCenter:im2.horizontalCenter;topPadding:5;bottomPadding:5;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
        Text { id:r3;text: Forecast.rain3;anchors.top:im3.bottom;anchors.horizontalCenter:im3.horizontalCenter;topPadding:5;bottomPadding:5;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
        Text { id:r4;text: Forecast.rain4;anchors.top:im4.bottom;anchors.horizontalCenter:im4.horizontalCenter;topPadding:5;bottomPadding:5;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
        Text { id:r5;text: Forecast.rain5;anchors.top:im5.bottom;anchors.horizontalCenter:im5.horizontalCenter;topPadding:5;bottomPadding:5;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
        Text { id:f1;text: Forecast.mintemp1;anchors.top:r1.bottom;anchors.right:f1m.left;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
        Text { id:f1m;text: " | ";anchors.top:f1.top;anchors.horizontalCenter:im1.horizontalCenter;font.bold:true;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
        Text { text: Forecast.maxtemp1;anchors.top:f1.top;anchors.left:f1m.right;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
        Text { id:f2;text: Forecast.mintemp2;anchors.top:r2.bottom;anchors.right:f2m.left;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
        Text { id:f2m;text: " | ";anchors.top:r2.bottom;anchors.horizontalCenter:im2.horizontalCenter;font.bold:true;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
        Text { text: Forecast.maxtemp2;anchors.top:f2.top;anchors.left:f2m.right;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
        Text { id:f3;text: Forecast.mintemp3;anchors.top:r3.bottom;anchors.right:f3m.left;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
        Text { id:f3m;text: " | ";anchors.top:r3.bottom;anchors.horizontalCenter:im3.horizontalCenter;font.bold:true;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
        Text { text: Forecast.maxtemp3;anchors.top:f3.top;anchors.left:f3m.right;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
        Text { id:f4;text: Forecast.mintemp4;anchors.top:r4.bottom;anchors.right:f4m.left;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
        Text { id:f4m;text: " | ";anchors.top:r4.bottom;anchors.horizontalCenter:im4.horizontalCenter;font.bold:true;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
        Text { text: Forecast.maxtemp4;anchors.top:f4.top;anchors.left:f4m.right;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
        Text { id:f5;text: Forecast.mintemp5;anchors.top:r5.bottom;anchors.right:f5m.left;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
        Text { id:f5m;text: " | ";anchors.top:r5.bottom;anchors.horizontalCenter:im5.horizontalCenter;font.bold:true;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
        Text { text: Forecast.maxtemp5;anchors.top:f5.top;anchors.left:f5m.right;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
    
  }
}
  
  Label {
        id: info3
        opacity: 0
        Layout.preferredWidth : 700
        Layout.alignment: Qt.AlignHCenter
        anchors.top:info2.bottom
        anchors.left:info2.left
        anchors.topMargin:-20
           
   Item {
        id:stock_market_info
        Layout.alignment:Qt.AlignHCenter
        Layout.preferredWidth : 700
        anchors.top:info3.bottom
        
        Text {id:dow;leftPadding:60;width:250;renderType: Text.QtRendering;antialiasing : true;text:" DOW ";color:font_color;font.bold:true;font.pointSize:18;font.family: font_style2}
        Text {id:nasdaq;width:250;leftPadding:60;renderType:Text.QtRendering;antialiasing : true;anchors.left:dowItem.right;text:" NASDAQ ";color:font_color;font.bold:true;font.pointSize:18;font.family: font_style2}
        Text {id:sp500;width:250;renderType:Text.QtRendering;antialiasing : true;anchors.left:nasdaqItem.right;leftPadding:40;text:" S&P 500 ";color:font_color;font.bold:true;font.pointSize:18;font.family: font_style2}
       
        Item {id:dowItem;anchors.fill:dow;anchors.horizontalCenter:dow.horizontalCenter;anchors.topMargin:35;anchors.top:dow.bottom;width:300
            Text {id:dow1;renderType:Text.QtRendering;antialiasing : true;text:dow_symbol+" ";color:dow_color;font.pointSize:18;font.family: font_style2}
        
            Text {id:dow2;anchors.top:dow.bottom;anchors.left:dow1.right;renderType:Text.QtRendering;antialiasing : true;text: Market.dow;color:font_color;font.pointSize:18;font.family: font_style2}
            Text {id:dow3;anchors.top:dow.bottom;anchors.left:dow2.right;renderType:Text.QtRendering;antialiasing : true;color:font_color;font.bold:true;font.pointSize:18;font.family: font_style2;text:"     |     ";leftPadding:5}
        }
        
        Item {
                 id:nasdaqItem;width:300;anchors.fill:nasdaq;anchors.horizontalCenter:nasdaq.horizontalCenter;anchors.top:nasdaq.bottom;anchors.topMargin:35;anchors.leftMargin:20
            Text {id:nasdaq1;anchors.top:nasdaq.bottom;anchors.left:dow3.right;renderType:Text.QtRendering;antialiasing : true;text:nasdaq_symbol+" ";color:nasdaq_color;font.pointSize:18;font.family: font_style2}
            Text {id:nasdaq2;anchors.top:nasdaq.bottom;anchors.left:nasdaq1.right;renderType:Text.QtRendering;antialiasing : true;text: Market.nasdaq;color:font_color;font.pointSize:18;font.family: font_style2}
            Text {id:nasdaq3;anchors.top:nasdaq.bottom;anchors.left:nasdaq2.right;renderType:Text.QtRendering;antialiasing : true;color:font_color;font.bold:true;font.pointSize:18;font.family: font_style2;text:"     |     ";leftPadding:5}
        }
        
        Item {
                id:sp500Item;width:300;anchors.fill:sp500;anchors.horizontalCenter:sp500.horizontalCenter;anchors.top:sp500.bottom;anchors.topMargin:35;anchors.leftMargin:20
        Text {id:sp500a;anchors.top:sp500.bottom;anchors.left:nasdaq3.right;renderType:Text.QtRendering;antialiasing : true;text:sp500_symbol+" ";color:sp500_color;font.pointSize:18;font.family: font_style2}
        Text {id:sp500b;anchors.top:sp500.bottom;anchors.left:sp500a.right;renderType:Text.QtRendering;antialiasing : true;text: Market.sp500;color:font_color;font.pointSize:18;font.family: font_style2}
        }
    }
}
Label {
        id: info4
        opacity: 0
        Layout.preferredWidth : 700
       // Layout.alignment:Qt.AlignHCenter
        anchors.top:info3.bottom
        anchors.left:info3.left
        anchors.topMargin:-20
     
     Item {
        id:commidities_info
        //Layout.alignment:Qt.AlignHCenter
        //Layout.alignment:Text.AlignHCenter
        anchors.top:info4.bottom
        anchors.left:info4.left
        anchors.leftMargin:20
        Text {id:oil;leftPadding:80;width:200;renderType: Text.QtRendering;antialiasing : true;text: " Oil ";color:font_color;font.bold:true;font.pointSize:18;font.family: font_style2}
        Text {id:gold;leftPadding:100;width:200;anchors.left:oilItem.right;renderType: Text.QtRendering;antialiasing : true;text: " Gold ";color:font_color;font.bold:true;font.pointSize:18;font.family: font_style2}
        Text {id:y10;leftPadding:140;width:200;anchors.left:goldItem.right;renderType: Text.QtRendering;antialiasing : true;text: "10Y Yield ";color:font_color;font.bold:true;font.pointSize:18;font.family: font_style2}
        
        Item {id:oilItem;anchors.fill:oil;anchors.horizontalCenter:oil.horizontalCenter;anchors.topMargin:35;anchors.top:oil.bottom;width:300
        
        Text {id:oil1;anchors.top:oil.bottom;anchors.left:oil.left;leftPadding:5;renderType: Text.QtRendering;antialiasing : true;text:oil_symbol+" ";color:oil_color;font.pointSize:18;font.family: font_style2}
        Text {id:oil2;anchors.top:oil.bottom;anchors.left:oil1.right;leftPadding:5;renderType: Text.QtRendering;antialiasing : true; text: Market.oil;color:font_color;font.pointSize:18;font.family: font_style2}
        Text {id:oil3;anchors.top:oil.bottom;anchors.left:oil2.right;renderType: Text.QtRendering;antialiasing : true;color:font_color;font.bold:true;font.pointSize:18;font.family: font_style2;text:"   |   "}
        }
        
        Item {id:goldItem;anchors.fill:gold;anchors.horizontalCenter:gold.horizontalCenter;anchors.topMargin:35;anchors.top:gold.bottom;anchors.leftMargin:20;anchors.rightMargin:20
        Text {id:gold1;leftPadding:15;anchors.top:gold.bottom;renderType: Text.QtRendering;antialiasing : true;text:gold_symbol+"  ";color:gold_color;font.pointSize:18;font.family: font_style2}
        Text {id:gold2;width:150;anchors.top:gold.bottom;anchors.left:gold1.right;renderType: Text.QtRendering;antialiasing : true; text: Market.gold;color:font_color;font.pointSize:18;font.family: font_style2}
        Text {id:gold3;anchors.top:gold.bottom;anchors.left:gold2.right;renderType: Text.QtRendering;antialiasing : true;color:font_color;font.bold:true;font.pointSize:18;leftPadding:35;font.family: font_style2;text:"   | "}
        }
        Item {id:y10Item;anchors.fill:y10;anchors.horizontalCenter:y10.horizontalCenter;anchors.topMargin:35;anchors.top:y10.bottom;width:300;anchors.leftMargin:100
        Text {id:y10a;leftPadding:20;anchors.top:y10.bottom;renderType: Text.QtRendering;antialiasing : true;text:y10_symbol+"  ";color:y10_color;font.pointSize:18;font.family: font_style2}
        Text {id:y10b;width:150;anchors.top:y10.bottom;anchors.left:y10a.right;renderType: Text.QtRendering;antialiasing : true;text: Market.yield10;color:font_color;font.pointSize:18;font.family: font_style2}
        }
   }
    }

ParallelAnimation {             //animate the info panes fade in and out
        running: true
        loops: Animation.Infinite
    
    SequentialAnimation {
        id:a1
       
       PauseAnimation { duration: 20000 }
        
        OpacityAnimator {
            target: info;
            from: 1;
            to: 0;
            duration: 500
    }
       
       
        OpacityAnimator {
            target: info2;
            from: 0;
            to: 1;
            duration: 1000
    }
    
     PauseAnimation { duration: 20000}
    
        OpacityAnimator {
            target: info2;
            from: 1;
            to: 0;
            duration: 500
    }
    
        OpacityAnimator {
            target: info3;
            from: 0;
            to: 1;
            duration: 1000
    }
    PauseAnimation { duration: 20000 }
    
        OpacityAnimator {
            target: info3;
            from: 1;
            to: 0;
            duration: 500
    }
    
        OpacityAnimator {
            target: info4;
            from: 0;
            to: 1;
            duration: 1000
    }
     PauseAnimation { duration: 20000}
    
        OpacityAnimator {
            target: info4;
            from: 1;
            to: 0;
            duration: 500
    }
    
     
        OpacityAnimator {
            target: info;
            from: 0;
            to: 1;
            duration: 1000
    }
  }
}       
    
    DataSource {
        id: timeSource
        engine: "time"
        connectedSources: ["Local"]
        interval: 1000*50
        onNewData: {
                    isDateChanged()
        }
     }
}
