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
// shows weather,email,stocks index

import QtQuick 2.9
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.5
import org.kde.plasma.core 2.0
import "../code/natday.js" as Event
import "../code/temp.js" as Weather
import "../code/gmail.js" as Gmail
import "../code/market.js" as Market
import "../code/forecast.js" as Forecast

ColumnLayout {
    spacing : 20
    Layout.preferredWidth : 600
    Layout.minimumWidth : 600
    
    Label {
        lineHeightMode: Text.FixedHeight
        lineHeight: 90
        topPadding : 60
        text: Qt.formatTime(timeSource.data["Local"]["DateTime"],"h:mm ap").replace("am", "").replace("pm", "")
                                                                            // removes am,pm
        // color: ColorScope.textColor
        color: "whitesmoke"
        Layout.alignment: Qt.AlignHCenter
        renderType: Text.QtRendering
        font {
            pointSize: 72
            family: "Noto Serif"
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
        color: "whitesmoke"
        lineHeightMode: Text.FixedHeight
       lineHeight: 35
        Layout.alignment: Qt.AlignHCenter
        topPadding: 15
        renderType: Text.QtRendering
        font {
            pointSize: 28
            // family: config.displayFont
            family: "Noto Serif"
        }
    }
    
    Text {
        id:nday
       bottomPadding: -25
        text: Event.today
        Layout.preferredWidth : 600
        Layout.fillWidth: true;
        horizontalAlignment: Text.AlignHCenter
        color: "whitesmoke"
        antialiasing : true
        Layout.alignment: Qt.AlignHCenter
        wrapMode:Text.WordWrap
        renderType: Text.QtRendering
        lineHeightMode: Text.FixedHeight
        lineHeight: 40
        font {
            pointSize: 18 
            // family: config.displayFont
            family: "Noto Serif"
            italic:true
            }        
        }
        
        ToolSeparator {
            orientation:Qt.Horizontal
            Layout.fillWidth: true
            contentItem: Rectangle {
                implicitWidth: 400
                implicitHeight: parent.vertical ? 20 : 2
                color: "gray"
            }
        }
        
        Item {
            height:15
        }
        
     Label {
     id: info 
      Layout.preferredWidth :400
     
     Image {
       id: current_weather_conditions_icon
       y: -47
       horizontalAlignment: Image.AlignLeft
       source : Weather.icon
       smooth: true
       sourceSize.width: 48
       sourceSize.height: 48
        }
           
        Text {
        id:current_weather_conditions
        y: -45
        x:50
        property var temp:readTempFile("/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/temp.txt")
        property var desc:readDescFile("/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/desc.txt")
        
        
        function readTempFile(fileUrl){     // read current weather temperature from text file
            var xhr = new XMLHttpRequest;
            xhr.open("GET", fileUrl); // set Method and File
            xhr.onreadystatechange = function () {
           if(xhr.readyState === XMLHttpRequest.DONE){ // if request_status == DONE
               var response = xhr.responseText;
               temp = response
               //read_txt.temp="46 - "
           }
       }
            xhr.send(); // begin the request
   }

        function readDescFile(fileUrl){     // read current weather conditions from text file
            var xhr = new XMLHttpRequest;
            xhr.open("GET", fileUrl); // set Method and File
            xhr.onreadystatechange = function () {
            if(xhr.readyState === XMLHttpRequest.DONE){ // if request_status == DONE
               var response = xhr.responseText;
               desc = response
               //read_txt.desc = "CLEAR"
           }
       }
            xhr.send(); // begin the request

   }
        text:"  "+temp+desc
        font.family: "Noto Sans"
        font.pointSize: 22
        font.capitalization: Font.Capitalize
        color: "whitesmoke"
        // color: ColorScope.textColor
        antialiasing : true
        }
        
        Timer{                  // timer to trigger update for weather temperature
        id: readTemp
        interval: 31 * 60 * 1000
        running: true
        repeat:  true
        onTriggered: read_txt.readTempFile("/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/temp.txt");
    }
    Timer{
        id: readDesc             // timer to trigger update for weather conditions
        interval: 31 * 60 * 1000
        running: true
        repeat:  true
        onTriggered: read_txt.readDescFile("/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/desc.txt");
    }
    Timer{
        id: readIcon             // timer to trigger update for weather condition icon
        interval: 31 * 60 * 1000
        running: true
        repeat:  true
        onTriggered: info.readIconFile("/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/icon.txt");
    }
        
    Image {
        id:email_icon
        y: -44
        x: 625
        source: "/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/icons/email3.png"
        smooth: true
        sourceSize.width: 42
        sourceSize.height: 42
        }
      
      Text {
        id:email_count
        y: -40
        x: 673
        text: Gmail.count
        font.family: "Noto Sans"
        font.bold:true
        font.pointSize:18
       // color: ColorScope.textColor
       color: "whitesmoke"
        antialiasing : true
    }
}

Label {
        id: info1
        opacity: 0
        Layout.preferredWidth :400   
        wrapMode:Text.Wrap
        elide: Text.ElideLeft
        Layout.fillWidth : false

   Image {
       id:weather_condition_icon
        y: -90
        source : Weather.icon
        smooth: true
        sourceSize.width: 48
        sourceSize.height: 48
        }
    Item {
        id: spacer
        width: 680
    
    Text {
        id:weather_conditions_summary
       topPadding: -90 
       leftPadding: 60
       text: Forecast.summary
       font.family: "Noto Sans"
       font.pointSize: 18
       color: "whitesmoke"
       wrapMode:Text.Wrap
       elide: Text.ElideLeft
       Layout.fillWidth : false
       width: spacer.width
       renderType: Text.QtRendering
       antialiasing : true
        }
   }
}

Label {
     id: info2
     opacity: 0
     Layout.preferredWidth :700
     Layout.alignment:Qt.AlignHCenter

       Grid {
        id:weather_forecast_5_days
        columns: 5
        leftPadding: 40
        columnSpacing : 100
        topPadding: -80
        bottomPadding: 10
        y: -40
        Layout.alignment:Text.AlignHCenter
        Text { Layout.fillWidth: true;text: Forecast.day1;color:"whitesmoke";font.bold:true;font.pointSize:16;font.family: "Noto Sans" }
        Text {  Layout.fillWidth: true;text: " "+Forecast.day2;color:"whitesmoke";font.bold:true;font.pointSize:16;font.family: "Noto Sans" }
        Text {  Layout.fillWidth: true;text: "  "+Forecast.day3;color:"whitesmoke";font.bold:true;font.pointSize:16;font.family: "Noto Sans" }
        Text {  Layout.fillWidth: true;text: " "+Forecast.day4;color:"whitesmoke";font.bold:true;font.pointSize:16;font.family: "Noto Sans" }
        Text {  Layout.fillWidth: true;text: "  "+Forecast.day5;color:"whitesmoke";font.bold:true;font.pointSize:16;font.family: "Noto Sans" }
    }

    Grid {
        id:weather_forecast_icons
        columns: 9
        columnSpacing : 25
        topPadding: -80
        leftPadding : 30
                
    Image { 
        source : Forecast.icon1
        smooth: true
        sourceSize.width: 64
        sourceSize.height: 64
    }
    Image {
        source : "../icons/blank.png"
        smooth: true
        sourceSize.width: 36
        sourceSize.height: 36
        }
    Image {
        source : Forecast.icon2
        smooth: true
        sourceSize.width: 64
        sourceSize.height: 64
    }
    Image {
        source : "../icons/blank.png"
        smooth: true
        sourceSize.width: 36
        sourceSize.height: 36
        }
    Image {
        source : Forecast.icon3
        smooth: true
        sourceSize.width: 64
        sourceSize.height: 64
}
    Image {
        source : "../icons/blank.png"
        smooth: true
        sourceSize.width: 36
        sourceSize.height: 36
        }

    Image {
        source : Forecast.icon4
        smooth: true
        sourceSize.width: 64
        sourceSize.height: 64
}
    Image {
        source : "../icons/blank.png"
        smooth: true
        sourceSize.width: 36
        sourceSize.height: 36
        }

    Image {
        source : Forecast.icon5
        smooth: true
        sourceSize.width: 64
        sourceSize.height: 64
}
    }
Grid {
        id:weather_temperatures_high_lows
        rows: 1
        rowSpacing : 15
        leftPadding : 30
        topPadding: 10
        y: -20
        Text {  Layout.fillWidth: true;horizontalAlignment: Text.AlignHCenter;text: Forecast.mintemp1;color:"whitesmoke";font.pointSize:16;font.family: "Noto Sans" }
        Text { text: " | ";color:"whitesmoke";font.pointSize:14;font.family: "Noto Sans"}
        Text {  Layout.fillWidth: true;horizontalAlignment: Text.AlignHCenter;text: Forecast.maxtemp1;color:"whitesmoke";font.pointSize:16;font.family: "Noto Sans" }
        Text { text: "               "}
        Text {  Layout.fillWidth: true;horizontalAlignment: Text.AlignHCenter;text: Forecast.mintemp2;color:"whitesmoke";font.pointSize:16;font.family: "Noto Sans" }
        Text { text: " | ";color:"whitesmoke";font.pointSize:14;font.family: "Noto Sans"}
        Text {  Layout.fillWidth: true;horizontalAlignment: Text.AlignHCenter;text: Forecast.maxtemp2;color:"whitesmoke";font.pointSize:16;font.family: "Noto Sans" }
        Text { text: "                "}
        Text {  Layout.fillWidth: true;horizontalAlignment: Text.AlignHCenter;text: Forecast.mintemp3;color:"whitesmoke" ;font.pointSize:16;font.family: "Noto Sans"}
        Text { text: " | ";color:"whitesmoke";font.pointSize:14;font.family: "Noto Sans"}
        Text {  Layout.fillWidth: true;horizontalAlignment: Text.AlignHCenter;text: Forecast.maxtemp3;color:"whitesmoke";font.pointSize:16;font.family: "Noto Sans" }
        Text { text: "                "}
        Text {  Layout.fillWidth: true;horizontalAlignment: Text.AlignHCenter;text: Forecast.mintemp4;color:"whitesmoke" ;font.pointSize:16;font.family: "Noto Sans"}
        Text { text: " | ";color:"whitesmoke";font.pointSize:14;font.family: "Noto Sans"}
        Text {  Layout.fillWidth: true;horizontalAlignment: Text.AlignHCenter;text: Forecast.maxtemp4;color:"whitesmoke" ;font.pointSize:16;font.family: "Noto Sans"}
        Text { text: "               "}
        Text {  Layout.fillWidth: true;horizontalAlignment: Text.AlignHCenter;text: Forecast.mintemp5;color:"whitesmoke" ;font.pointSize:16;font.family: "Noto Sans"}
        Text { text: " | ";color:"whitesmoke";font.pointSize:14;font.family: "Noto Sans"}
        Text {  Layout.fillWidth: true;horizontalAlignment: Text.AlignHCenter;text: Forecast.maxtemp5;color:"whitesmoke" ;font.pointSize:16;font.family: "Noto Sans"}
}
Grid {
        id:weather_rain_chances
        columns: 5
        topPadding: 35
        columnSpacing : 110
        y: -10
        x:50
        Text {text: Forecast.rain1;color:"whitesmoke";font.pointSize:16;font.family: "Noto Sans"}
        Text {text: Forecast.rain2;color:"whitesmoke";font.pointSize:16;font.family: "Noto Sans"}
        Text {text: Forecast.rain3;color:"whitesmoke";font.pointSize:16;font.family: "Noto Sans"}
        Text {text: Forecast.rain4;color:"whitesmoke";font.pointSize:16;font.family: "Noto Sans"}
        Text {text: Forecast.rain5;color:"whitesmoke";font.pointSize:16;font.family: "Noto Sans"}
} 
     }
     
  Label {
        id: info3
        opacity: 0
        Layout.preferredWidth : 700
        Layout.alignment: Qt.AlignHCenter
           
   Grid {
        id:stock_market_info
        columns: 5
        Layout.alignment:Qt.AlignHCenter
        y:-160
        x: 60
        Text { text: "      DOW";color:"whitesmoke";font.bold:true;font.pointSize:18;font.family: "Noto Sans"}
        Text { text: "                                         "}
        Text { text: "NASDAQ";color:"whitesmoke";font.bold:true;font.pointSize:18;font.family: "Noto Sans"}
        Text { text: "                             "}
        Text { text: "S&P 500";color:"whitesmoke";font.bold:true;font.pointSize:18;font.family: "Noto Sans"}
   }
    
   Grid {
        rows: 1
        spacing: 5
        y:-130
        x: 15
        Layout.alignment:Qt.AlignHCenter
        topPadding: 10
        Text { text: Market.dow;color:"whitesmoke";font.pointSize:19;font.family: "Noto Sans"}
        Text { text: Market.nasdaq;color:"whitesmoke";font.pointSize:19;font.family: "Noto Sans"}
        Text { text: Market.sp500;color:"whitesmoke";font.pointSize:19;font.family: "Noto Sans"}
    }
}
Label {
        id: info4
        opacity: 0
        Layout.preferredWidth : 700
        Layout.minimumWidth : 700
        Layout.alignment:Qt.AlignHCenter
     
     Grid {
         id:commidities_info
        columns: 5
        Layout.alignment:Qt.AlignHCenter
        y:-200
        x: 60
        Text { text: "         Oil";color:"whitesmoke";font.bold:true;font.pointSize:18;font.family: "Noto Sans"}
        Text { text: "                                              "}
        Text { text: "Gold";color:"whitesmoke";font.bold:true;font.pointSize:18;font.family: "Noto Sans"}
        Text { text: "                                           "}
        Text { text: " 10Y Yield";color:"whitesmoke";font.bold:true;font.pointSize:18;font.family: "Noto Sans"}
   }

     
    Grid {
        rows: 1
        spacing: 15
        y:-175
        x: 70
        topPadding: 10
        Layout.alignment:Qt.AlignHCenter
        Text { text: Market.oil;color:"whitesmoke";font.pointSize:18;font.family: "Noto Sans"}
        Text { text: Market.gold;color:"whitesmoke";font.pointSize:18;font.family: "Noto Sans"}
        Text { text: Market.yield10;color:"whitesmoke";font.pointSize:18;font.family: "Noto Sans"}
     }
     }

ParallelAnimation {             //animate the info panes fade in and out
        running: true
        loops: Animation.Infinite
    
    SequentialAnimation {
        running: true
        id:a1
       
       PauseAnimation { duration: 25000 }
        
        OpacityAnimator {
            target: info;
            from: 1;
            to: 0;
            duration: 1500
            running: true
    }
       
        OpacityAnimator {
            target: info1;
            from: 0;
            to: 1;
            duration: 1000
            running: true
    }
    
     PauseAnimation { duration: 25000}
       
        OpacityAnimator {
            target: info1;
            from: 1;
            to: 0;
            duration: 1000
            running: true
    }
       
        OpacityAnimator {
            target: info2;
            from: 0;
            to: 1;
            duration: 1500
            running: true
    }
    
     PauseAnimation { duration: 25000}
    
        OpacityAnimator {
            target: info2;
            from: 1;
            to: 0;
            duration: 1000
            running: true
    }
    
        OpacityAnimator {
            target: info3;
            from: 0;
            to: 1;
            duration: 1500
            //easing.type: Easing.OutCirc
            running: true
    }
    PauseAnimation { duration: 15000 }
    
        OpacityAnimator {
            target: info3;
            from: 1;
            to: 0;
            duration: 1000
            // easing.type: Easing.InCirc
            running: true
    }
    
        OpacityAnimator {
            target: info4;
            from: 0;
            to: 1;
            duration: 1500
            // easing.type: Easing.OutCirc
            running: true
    }
     PauseAnimation { duration: 15000}
    
        OpacityAnimator {
            target: info4;
            from: 1;
            to: 0;
            duration: 1000
            // easing.type: Easing.InCirc
            running: true
    }
    
     
        OpacityAnimator {
            target: info;
            from: 0;
            to: 1;
            duration: 1500
            // easing.type: Easing.OutnCirc
            running: true
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
