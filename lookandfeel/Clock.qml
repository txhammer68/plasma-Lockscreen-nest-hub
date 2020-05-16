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
import "../code/natday.js" as Event
import "../code/gmail.js" as Gmail
import "../code/market.js" as Market
import "../code/forecast.js" as Forecast

ColumnLayout {
    spacing : 20
    Layout.preferredWidth : 600
    property var font_color:"white"         // change font color
    property var font_style1:"Noto Serif"   // change clock font
    property var font_style2:"Noto Sans"    // change info status font
    property var dow_color: Market.dow_up ? "green" : "red"
    property var nasdaq_color: Market.nasdaq_up ? "green" : "red"
    property var sp500_color: Market.sp500_up ? "green" : "red"
    property var oil_color: Market.oil_up ? "green" : "red"
    property var gold_color: Market.gold_up ? "green" : "red"
    property var y10_color: Market.y10_up ? "green" : "red"
    property var dow_symbol: Market.dow_up ? "⏶" : "⏷"
    property var nasdaq_symbol: Market.nasdaq_up ? "⏶" : "⏷"
    property var sp500_symbol: Market.sp500_up ? "⏶" : "⏷"
    property var oil_symbol: Market.oil_up ? "⏶" : "⏷"
    property var gold_symbol: Market.gold_up ? "⏶" : "⏷"
    property var y10_symbol: Market.y10_up ? "⏶" : "⏷"
    
    
    function readIconFile(fileUrl){  // read weather icon code from file
       var xhr = new XMLHttpRequest;
       xhr.open("GET", fileUrl); // set Method and File
       xhr.onreadystatechange = function () {
           if(xhr.readyState === XMLHttpRequest.DONE){ // if request_status == DONE
               var response = xhr.responseText;
               wIcon.wIconurl  = response;
           }
       }
       xhr.send(); // begin the request
   }
   
   function readTempFile(fileUrl) {     // read current weather temperature from text file
            var xhr = new XMLHttpRequest;
            xhr.open("GET", fileUrl); // set Method and File
            xhr.onreadystatechange = function () {
           if(xhr.readyState === XMLHttpRequest.DONE){ // if request_status == DONE
               var response = xhr.responseText;
               current_weather_conditions.temp = response
           }
       }
            xhr.send(); // begin the request
   }
   
   function readDescFile(fileUrl) {     // read current weather conditions from text file
            var xhr = new XMLHttpRequest;
            xhr.open("GET", fileUrl); // set Method and File
            xhr.onreadystatechange = function () {
            if(xhr.readyState === XMLHttpRequest.DONE){ // if request_status == DONE
               var response = xhr.responseText;
               current_weather_conditions.desc = response
           }
       }
            xhr.send(); // begin the request
   }
    
    
function readForecastFile(fileUrl){     // read current weather conditions from text file
            var xhr = new XMLHttpRequest;
            xhr.open("GET", fileUrl); // set Method and File
            xhr.onreadystatechange = function () {
            if(xhr.readyState === XMLHttpRequest.DONE){ // if request_status == DONE
               var response = xhr.responseText;
               current_weather_conditions.forecast = response
           }
         }
            xhr.send(); // begin the request
       }

    Label {
        lineHeightMode: Text.FixedHeight
        lineHeight: 90
        topPadding : 60
        text: Qt.formatTime(timeSource.data["Local"]["DateTime"],"h:mm ap").replace("am", "").replace("pm", "")
                                                                            // removes am,pm
        // color: ColorScope.textColor
        color: font_color
        Layout.alignment: Qt.AlignHCenter
        renderType: Text.QtRendering
        font {
            pointSize: 72
            family: font_style1
        }
    }
    Label {
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
        lineHeightMode: Text.FixedHeight
        lineHeight: 35
        Layout.alignment: Qt.AlignHCenter
        topPadding: 15
        renderType: Text.QtRendering
        font {
            pointSize: 28
            // family: config.displayFont
            family: font_style1
        }
    }
    
    Text {
        id:calEvents
        bottomPadding: -25
        text: Event.today
        Layout.preferredWidth : 600
        Layout.fillWidth : false
        width: 600
        // Layout.fillWidth: true;
        horizontalAlignment: Text.AlignHCenter
        color: font_color
        antialiasing : true
        Layout.alignment: Qt.AlignHCenter
        wrapMode:Text.WordWrap
        renderType: Text.QtRendering
        lineHeightMode: Text.FixedHeight
        lineHeight: 40
        font {
            pointSize: 24 
            // family: config.displayFont
            family: "Ink Free"
            italic:true
            }        
        }
        
        ToolSeparator {
            id:ts
            orientation:Qt.Horizontal
            Layout.fillWidth: true
            contentItem: Rectangle {
                implicitWidth: 400
                implicitHeight: 2
                color: "gray"
                antialiasing : true
            }
        }
        
        Item {              // spacer
            id:spc1
            height:15
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
       property var wIconurl:readIconFile("/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/icon.txt")
       Component.onCompleted:readIconFile("/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/icon.txt")
       horizontalAlignment: Image.AlignLeft
       asynchronous : true
       cache: false
       source: wIconurl
       smooth: true
       sourceSize.width: 64
       sourceSize.height: 64
       
       Timer{
        id: readIcon             // timer to trigger update for weather condition icon
        interval: 31 * 60 * 1000  // every 30 minutes
        running: true
        repeat:  true
        onTriggered: readIconFile("/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/icon.txt");
        }
    }

        Text {
        id:current_weather_conditions
        anchors.topMargin:5
        anchors.top:wIcon.top
        anchors.left:wIcon.right
        property var temp:readTempFile("/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/temp.txt")
        property var desc:readDescFile("/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/desc.txt")
        property var forecast:readForecastFile("/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/forecast.txt")
        Component.onCompleted: {
            readTempFile("/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/temp.txt")
            readDescFile("/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/desc.txt")
            readForecastFile("/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/forecast.txt")
        }
        text:"    "+temp+desc+'\n'+"   "+forecast
        font.family: font_style2
        font.pointSize: 18
        font.capitalization: Font.Capitalize
        color: font_color
        antialiasing : true
        renderType: Text.QtRendering
        
        Timer{                  // timer to trigger update for weather temperature
        id: readTemp
        interval: 31* 60 * 1000 // every 30 minutes
        running: true
        repeat:  true
        onTriggered: readTempFile("/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/temp.txt")
    }
    Timer{
        id: readDesc             // timer to trigger update for weather conditions
        interval: 31* 60 * 1000   // every 30 minutes
        running: true
        repeat:  true
        onTriggered: readDescFile("/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/desc.txt");
    }
    Timer {
            id: readForecast            // timer to trigger update for weather condition icon
            interval: 31 * 60 * 1000  // every 60 minutes
            running: true
            repeat:  true
            onTriggered: readForecastFile("/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/forecast.txt");
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
        id:email_count
        anchors.topMargin: 5
        anchors.leftMargin:5
        anchors.top:wIcon.top
        anchors.left:email_icon.right
        text: Gmail.count
        font.family: font_style2
        font.bold:true
        font.pointSize:18
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

     Grid {
        columns: 5
        columnSpacing : 200
        anchors.top:info2.bottom
        anchors.left:info2.left
        anchors.leftMargin:30
        Text {id:d1;text:Forecast.day1;width:120;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
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
    Text {id:d2;width:140; leftPadding:45;anchors.left:d1.right;text: Forecast.day2;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
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
    Text {id:d3;width:140; leftPadding:45;anchors.left:d2.right;text: Forecast.day3;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
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
    Text {id:d4;width:140; leftPadding:45;anchors.left:d3.right;text: Forecast.day4;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
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
    Text {id:d5;width:140; leftPadding:45;anchors.left:d4.right;text: Forecast.day5;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
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
    Text { id:f1m;text: " | ";anchors.top:f1.top;anchors.horizontalCenter:im1.horizontalCenter;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
    Text { text: Forecast.maxtemp1;anchors.top:f1.top;anchors.left:f1m.right;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
    Text { id:f2;text: Forecast.mintemp2;anchors.top:r2.bottom;anchors.right:f2m.left;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
    Text { id:f2m;text: " | ";anchors.top:r2.bottom;anchors.horizontalCenter:im2.horizontalCenter;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
    Text { text: Forecast.maxtemp2;anchors.top:f2.top;anchors.left:f2m.right;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
    Text { id:f3;text: Forecast.mintemp3;anchors.top:r3.bottom;anchors.right:f3m.left;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
    Text { id:f3m;text: " | ";anchors.top:r3.bottom;anchors.horizontalCenter:im3.horizontalCenter;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
    Text { text: Forecast.maxtemp3;anchors.top:f3.top;anchors.left:f3m.right;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
    Text { id:f4;text: Forecast.mintemp4;anchors.top:r4.bottom;anchors.right:f4m.left;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
    Text { id:f4m;text: " | ";anchors.top:r4.bottom;anchors.horizontalCenter:im4.horizontalCenter;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
    Text { text: Forecast.maxtemp4;anchors.top:f4.top;anchors.left:f4m.right;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
    Text { id:f5;text: Forecast.mintemp5;anchors.top:r5.bottom;anchors.right:f5m.left;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
    Text { id:f5m;text: " | ";anchors.top:r5.bottom;anchors.horizontalCenter:im5.horizontalCenter;font.pointSize:16;font.family: font_style2;color: font_color;antialiasing : true;renderType: Text.QtRendering}
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
        anchors.topMargin:-30
           
   Grid {
        id:stock_market_info
        columns: 3
        Layout.alignment:Qt.AlignHCenter
        Layout.preferredWidth : 700
        anchors.top:info3.bottom
        anchors.left:info3.left
        anchors.leftMargin:20
        Text {id:dow;leftPadding:75;width:250;renderType: Text.QtRendering;antialiasing : true;text:" DOW ";color:font_color;font.bold:true;font.pointSize:18;font.family: font_style2}
        Text {id:nasdaq;width:250;leftPadding:30;anchors.left:dow.right;renderType:Text.QtRendering;antialiasing : true;text:"  NASDAQ ";color:font_color;font.bold:true;font.pointSize:18;font.family: font_style2}
        Text {id:sp500;width:250;leftPadding:20;anchors.left:nasdaq.right;renderType:Text.QtRendering;antialiasing : true;text:" S&P 500";color:font_color;font.bold:true;font.pointSize:18;font.family: font_style2}
        Text {id:dow1;anchors.top:dow.bottom;anchors.left:dow.left;leftPadding:-10;topPadding:-5;renderType:Text.QtRendering;antialiasing : true;text:dow_symbol+" ";color:dow_color;font.pointSize:32;font.family: font_style2
        Text {id:dow2;anchors.top:dow.bottom;anchors.left:dow1.right;topPadding:5;renderType:Text.QtRendering;antialiasing : true;text: Market.dow;color:font_color;font.pointSize:18;font.family: font_style2}
        Text {id:dow3;anchors.top:dow.bottom;anchors.left:dow2.right;topPadding:5;renderType:Text.QtRendering;antialiasing : true;color:font_color;font.bold:true;font.pointSize:18;font.family: font_style2;text:"     |     ";leftPadding:5}
        Text {id:nasdaq1;anchors.top:nasdaq.bottom;anchors.left:dow3.right;topPadding:-5;renderType:Text.QtRendering;antialiasing : true;text:nasdaq_symbol+" ";color:nasdaq_color;font.pointSize:32;font.family: font_style2}
        Text {id:nasdaq2;anchors.top:nasdaq.bottom;anchors.left:nasdaq1.right;topPadding:5;renderType:Text.QtRendering;antialiasing : true;text: Market.nasdaq;color:font_color;font.pointSize:18;font.family: font_style2}
        Text {id:nasdaq3;anchors.top:nasdaq.bottom;anchors.left:nasdaq2.right;topPadding:5;renderType:Text.QtRendering;antialiasing : true;color:font_color;font.bold:true;font.pointSize:18;font.family: font_style2;text:"     |     ";leftPadding:5}
        Text {id:sp500a;anchors.top:sp500.bottom;anchors.left:nasdaq3.right;topPadding:-5;renderType:Text.QtRendering;antialiasing : true;text:sp500_symbol+" ";color:sp500_color;font.pointSize:32;font.family: font_style2}
        Text {id:sp500b;anchors.top:sp500.bottom;anchors.left:sp500a.right;topPadding:5;renderType:Text.QtRendering;antialiasing : true;text: Market.sp500;color:font_color;font.pointSize:18;font.family: font_style2}
        }
    }
}
Label {
        id: info4
        opacity: 0
        Layout.preferredWidth : 700
        Layout.alignment:Qt.AlignHCenter
        anchors.top:info3.bottom
        anchors.left:info3.left
        anchors.topMargin:-30
     
     Grid {
         id:commidities_info
        columns: 5
        Layout.alignment:Qt.AlignHCenter
        anchors.top:info4.bottom
        anchors.left:info4.left
        anchors.leftMargin:20
        Text {id:oil;leftPadding:65;width:250;renderType: Text.QtRendering;antialiasing : true;text: " Oil ";color:font_color;font.bold:true;font.pointSize:18;font.family: font_style2}
        Text {id:gold;width:250;leftPadding:15;anchors.left:oil.right;renderType: Text.QtRendering;antialiasing : true;text: " Gold";color:font_color;font.bold:true;font.pointSize:18;font.family: font_style2}
        Text {id:y10;width:200;leftPadding:-15;anchors.left:gold.right;renderType: Text.QtRendering;antialiasing : true;text: "10Y Yield";color:font_color;font.bold:true;font.pointSize:18;font.family: font_style2}
        Text {id:oil1;anchors.top:oil.bottom;anchors.left:oil.left;leftPadding:-10;topPadding:-5;renderType: Text.QtRendering;antialiasing : true;text:oil_symbol;color:oil_color;font.pointSize:32;font.family: font_style2}
        Text {id:oil2;width:150;anchors.top:oil.bottom;anchors.left:oil1.right;leftPadding:5;topPadding:5;renderType: Text.QtRendering;antialiasing : true; text: Market.oil;color:font_color;font.pointSize:18;font.family: font_style2}
        Text {id:oil3;anchors.top:oil.bottom;anchors.left:oil2.right;renderType: Text.QtRendering;antialiasing : true;color:font_color;font.bold:true;font.pointSize:18;font.family: font_style2;text:" | ";leftPadding:1}
        Text {id:gold1;anchors.top:gold.bottom;anchors.left:oil3.right;leftPadding:5;topPadding:-5;renderType: Text.QtRendering;antialiasing : true;text:gold_symbol;color:gold_color;font.pointSize:32;font.family: font_style2}
        Text {id:gold2;width:150;anchors.top:gold.bottom;anchors.left:gold1.right;leftPadding:5;topPadding:5;renderType: Text.QtRendering;antialiasing : true; text: Market.gold;color:font_color;font.pointSize:18;font.family: font_style2}
        Text {id:gold3;anchors.top:gold.bottom;anchors.left:gold2.right;renderType: Text.QtRendering;antialiasing : true;color:font_color;font.bold:true;font.pointSize:18;leftPadding:35;font.family: font_style2;text:" | "}
        Text {id:y10a;anchors.top:y10.bottom;anchors.left:gold3.right;leftPadding:15;topPadding:-5;renderType: Text.QtRendering;antialiasing : true;text:y10_symbol;color:y10_color;font.pointSize:32;font.family: font_style2}
        Text {id:y10b;width:150;anchors.top:y10.bottom;anchors.left:y10a.right;topPadding:8;renderType: Text.QtRendering;antialiasing : true;leftPadding:10;text: Market.yield10;color:font_color;font.pointSize:18;font.family: font_style2}
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
            duration: 1500
    }
       
       
        OpacityAnimator {
            target: info2;
            from: 0;
            to: 1;
            duration: 1500
    }
    
     PauseAnimation { duration: 20000}
    
        OpacityAnimator {
            target: info2;
            from: 1;
            to: 0;
            duration: 1000
    }
    
        OpacityAnimator {
            target: info3;
            from: 0;
            to: 1;
            duration: 1500
    }
    PauseAnimation { duration: 20000 }
    
        OpacityAnimator {
            target: info3;
            from: 1;
            to: 0;
            duration: 1000
    }
    
        OpacityAnimator {
            target: info4;
            from: 0;
            to: 1;
            duration: 1500
    }
     PauseAnimation { duration:     20000}
    
        OpacityAnimator {
            target: info4;
            from: 1;
            to: 0;
            duration: 1000
    }
    
     
        OpacityAnimator {
            target: info;
            from: 0;
            to: 1;
            duration: 1500
    }
  }
}       
    
    DataSource {
        id: timeSource
        engine: "time"
        connectedSources: ["Local"]
        interval: 1000
    }
}
