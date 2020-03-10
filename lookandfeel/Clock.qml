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

import QtQuick 2.9
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.5
import org.kde.plasma.core 2.0
import "../code/natday.js" as Event
// import "../code/temp.js" as Weather
import "../code/gmail.js" as Gmail
import "../code/market.js" as Market
import "../code/forecast.js" as Forecast

ColumnLayout {
    spacing : 20
    Layout.preferredWidth : 600
    //Layout.minimumWidth : 600
    property var font_color:"whitesmoke"
    property var font_style1:"Noto Serif"
    property var font_style2:"Noto Sans"
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
        //Layout.preferredWidth : 500
        Layout.fillWidth : false
        width: 700
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
            pointSize: 18 
            // family: config.displayFont
            family: font_style1
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
                antialiasing : true
            }
        }
        
        Item {              // spacer
            height:15
        }
        
Label {
    id: info 
    Layout.preferredWidth :400
      
     Image {
       id: wIcon
       y: -55
       property var wIconurl:readIconFile("/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/icon.txt")
       Component.onCompleted:readIconFile("/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/icon.txt")
       
       function readIconFile(fileUrl){  // read icon code from file
       var xhr = new XMLHttpRequest;
       xhr.open("GET", fileUrl); // set Method and File
       xhr.onreadystatechange = function () {
           if(xhr.readyState === XMLHttpRequest.DONE){ // if request_status == DONE
               var response = xhr.responseText;
               wIconurl  = response;
           }
       }
       xhr.send(); // begin the request
   }
       horizontalAlignment: Image.AlignLeft
       asynchronous : true
       cache: false
       // source : Weather.icon
       source: wIcon.wIconurl
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
        y:-45
        x:50
        property var temp:readTempFile("/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/temp.txt")
        property var desc:readDescFile("/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/desc.txt")
        Component.onCompleted:readTempFile("/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/temp.txt")
        
        function readTempFile(fileUrl) {     // read current weather temperature from text file
            var xhr = new XMLHttpRequest;
            xhr.open("GET", fileUrl); // set Method and File
            xhr.onreadystatechange = function () {
           if(xhr.readyState === XMLHttpRequest.DONE){ // if request_status == DONE
               var response = xhr.responseText;
               temp = response
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
               desc = response
           }
       }
            xhr.send(); // begin the request
   }
        text:"    "+temp+desc
        font.family: font_style2
        font.pointSize: 22
        font.capitalization: Font.Capitalize
        color: font_color
        // color: ColorScope.textColor
        antialiasing : true
        renderType: Text.QtRendering
        
        Timer{                  // timer to trigger update for weather temperature
        id: readTemp
        interval: 31* 60 * 1000 // every 30 minutes
        running: true
        repeat:  true
        onTriggered: current_weather_conditions.readTempFile("/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/temp.txt")
    }
    Timer{
        id: readDesc             // timer to trigger update for weather conditions
        interval: 31* 60 * 1000   // every 30 minutes
        running: true
        repeat:  true
        onTriggered: current_weather_conditions.readDescFile("/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/desc.txt");
    }
}
    
        
    Image {
        id:email_icon
        y: -55
        x: 625
        source: "../icons/email3.png"
        // source: "//usr/share/icons/breeze-dark/actions/24/gnumeric-link-email.svg"
        smooth: true
        sourceSize.width: 48
        sourceSize.height: 48
        }
      
      Text {
        id:email_count
        y: -50
        x: 675
        text: Gmail.count
        font.family: font_style2
        font.bold:true
        font.pointSize:18
       // color: ColorScope.textColor
       color: font_color
       antialiasing : true
       renderType: Text.QtRendering
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
        y: -95
        source : wIcon.wIconurl
        smooth: true
        sourceSize.width: 64
        sourceSize.height: 64
        }
    Item {
        id: spacer
        width: 680
    }
    
    Text {
       id:weather_conditions_summary
       property var forecast:readForecastFile("/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/forecast.txt")
       topPadding: -87
       leftPadding: 65
       Component.onCompleted:readForecastFile("/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/forecast.txt")
       
       function readForecastFile(fileUrl){     // read current weather conditions from text file
            var xhr = new XMLHttpRequest;
            xhr.open("GET", fileUrl); // set Method and File
            xhr.onreadystatechange = function () {
            if(xhr.readyState === XMLHttpRequest.DONE){ // if request_status == DONE
               var response = xhr.responseText;
               forecast = response
           }
         }
            xhr.send(); // begin the request
       }
       text: "   "+forecast
       font.family: font_style2
       font.pointSize: 18
       color: font_color
       wrapMode:Text.Wrap
       elide: Text.ElideLeft
       Layout.fillWidth : false
       width: 700
       renderType: Text.QtRendering
       antialiasing : true
      
        Timer {
            id: readForecast            // timer to trigger update for weather condition icon
            interval: 61 * 60 * 1000  // every 60 minutes
            running: true
            repeat:  true
            onTriggered: weather_conditions_summary.readForecastFile("/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/forecast.txt");
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
        Text {id:d1;renderType: Text.QtRendering;antialiasing : true;Layout.fillWidth: true;text: Forecast.day1;color:font_color;font.bold:true;font.pointSize:16;font.family: font_style2 }
        Text {id:d2;renderType: Text.QtRendering;antialiasing : true;Layout.fillWidth: true;text: " "+Forecast.day2;color:font_color;font.bold:true;font.pointSize:16;font.family: font_style2 }
        Text {id:d3;renderType: Text.QtRendering;antialiasing : true;Layout.fillWidth: true;text: "  "+Forecast.day3;color:font_color;font.bold:true;font.pointSize:16;font.family: font_style2 }
        Text {id:d4;renderType: Text.QtRendering;antialiasing : true;Layout.fillWidth: true;text: " "+Forecast.day4;color:font_color;font.bold:true;font.pointSize:16;font.family: font_style2 }
        Text {id:d5;renderType: Text.QtRendering;antialiasing : true;Layout.fillWidth: true;text: "  "+Forecast.day5;color:font_color;font.bold:true;font.pointSize:16;font.family: font_style2 }
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
        id:weather_rain_chances
        //columns: 5
        rows:1
        //topPadding: 15
        //columnSpacing : 105
        rowSpacing :45
        y: -10
        x:50
        Text { Layout.fillWidth: true;renderType: Text.QtRendering;antialiasing : true;text: " "+Forecast.rain1;color:font_color;font.pointSize:16;font.family: font_style2}
        Text { Layout.fillWidth: true;renderType: Text.QtRendering;antialiasing : true;text: "                    "+Forecast.rain2;color:font_color;font.pointSize:16;font.family: font_style2}
        Text { Layout.fillWidth: true;renderType: Text.QtRendering;antialiasing : true;text: "                       "+Forecast.rain3;color:font_color;font.pointSize:16;font.family: font_style2}
        Text { Layout.fillWidth: true;renderType: Text.QtRendering;antialiasing : true;text: "                     "+Forecast.rain4;color:font_color;font.pointSize:16;font.family: font_style2}
        Text { Layout.fillWidth: true;renderType: Text.QtRendering;antialiasing : true;text: "                    "+Forecast.rain5;color:font_color;font.pointSize:16;font.family: font_style2}
} 

Grid {
        id:weather_temperatures_high_lows
        rows: 1
        rowSpacing : 15
        leftPadding : 30
        topPadding: 30
        // y: -20
        Text {renderType: Text.QtRendering;antialiasing : true;Layout.fillWidth: true;horizontalAlignment: Text.AlignHCenter;text: Forecast.mintemp1;color:font_color;font.pointSize:16;font.family: font_style2 }
        Text {renderType: Text.QtRendering;antialiasing : true;text: " | ";color:font_color;font.pointSize:14;font.family: font_style2}
        Text {renderType: Text.QtRendering;antialiasing : true;Layout.fillWidth: true;horizontalAlignment: Text.AlignHCenter;text: Forecast.maxtemp1;color:font_color;font.pointSize:16;font.family: font_style2 }
        Text {renderType: Text.QtRendering;antialiasing : true;text: "               "}
        Text {renderType: Text.QtRendering;antialiasing : true;Layout.fillWidth: true;horizontalAlignment: Text.AlignHCenter;text: Forecast.mintemp2;color:font_color;font.pointSize:16;font.family: font_style2 }
        Text {renderType: Text.QtRendering;antialiasing : true;text: " | ";color:font_color;font.pointSize:14;font.family: font_style2}
        Text {renderType: Text.QtRendering;antialiasing : true;Layout.fillWidth: true;horizontalAlignment: Text.AlignHCenter;text: Forecast.maxtemp2;color:font_color;font.pointSize:16;font.family: font_style2 }
        Text {renderType: Text.QtRendering;antialiasing : true;text: "                "}
        Text {renderType: Text.QtRendering;antialiasing : true;Layout.fillWidth: true;horizontalAlignment: Text.AlignHCenter;text: Forecast.mintemp3;color:font_color ;font.pointSize:16;font.family: font_style2}
        Text {renderType: Text.QtRendering;antialiasing : true;text: " | ";color:font_color;font.pointSize:14;font.family: font_style2}
        Text {renderType: Text.QtRendering;antialiasing : true;Layout.fillWidth: true;horizontalAlignment: Text.AlignHCenter;text: Forecast.maxtemp3;color:font_color;font.pointSize:16;font.family: font_style2 }
        Text {renderType: Text.QtRendering;antialiasing : true;text: "                "}
        Text {renderType: Text.QtRendering;antialiasing : true;Layout.fillWidth: true;horizontalAlignment: Text.AlignHCenter;text: Forecast.mintemp4;color:font_color ;font.pointSize:16;font.family: font_style2}
        Text {renderType: Text.QtRendering;antialiasing : true;text: " | ";color:font_color;font.pointSize:14;font.family: font_style2}
        Text {renderType: Text.QtRendering;antialiasing : true;Layout.fillWidth: true;horizontalAlignment: Text.AlignHCenter;text: Forecast.maxtemp4;color:font_color ;font.pointSize:16;font.family: font_style2}
        Text {renderType: Text.QtRendering;antialiasing : true;text: "               "}
        Text {renderType: Text.QtRendering;antialiasing : true;Layout.fillWidth: true;horizontalAlignment: Text.AlignHCenter;text: Forecast.mintemp5;color:font_color ;font.pointSize:16;font.family: font_style2}
        Text {renderType: Text.QtRendering;antialiasing : true;text: " | ";color:font_color;font.pointSize:14;font.family: font_style2}
        Text {renderType: Text.QtRendering;antialiasing : true;Layout.fillWidth: true;horizontalAlignment: Text.AlignHCenter;text: Forecast.maxtemp5;color:font_color ;font.pointSize:16;font.family: font_style2}
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
        Layout.preferredWidth : 700
        y:-160
        x: 60
        Text { renderType: Text.QtRendering;antialiasing : true;text: "      DOW";color:font_color;font.bold:true;font.pointSize:18;font.family: font_style2}
        Text { text: "                                         "}
        Text { renderType: Text.QtRendering;antialiasing : true;text: "NASDAQ";color:font_color;font.bold:true;font.pointSize:18;font.family: font_style2}
        Text { text: "                               "}
        Text { renderType: Text.QtRendering;antialiasing : true;text: "S&P 500";color:font_color;font.bold:true;font.pointSize:18;font.family: font_style2}
   }
    
   Grid {
        rows: 1
        // spacing: 5
        y:-130
        //x: 10
        //Layout.alignment:Qt.AlignHCenter
        Layout.preferredWidth : 700
        topPadding: 10
        Text {topPadding: -15;renderType: Text.QtRendering;antialiasing : true;text:dow_symbol+" ";color:dow_color;font.pointSize:32;font.family: font_style2}
        Text {renderType: Text.QtRendering;antialiasing : true;text: Market.dow;color:font_color;font.pointSize:18;font.family: font_style2}
        Text {renderType: Text.QtRendering;antialiasing : true;color:font_color;font.bold:true;font.pointSize:18;font.family: font_style2;text:" | "}
        Text {topPadding: -15;renderType: Text.QtRendering;antialiasing : true;text:nasdaq_symbol+" ";color:nasdaq_color;font.pointSize:32;font.family: font_style2}
        Text {renderType: Text.QtRendering;antialiasing : true;text: Market.nasdaq;color:font_color;font.pointSize:18;font.family: font_style2}
        Text {renderType: Text.QtRendering;antialiasing : true;color:font_color;font.bold:true;font.pointSize:18;font.family: font_style2;text:" | "}
        Text {topPadding: -15;renderType: Text.QtRendering;antialiasing : true;text:sp500_symbol+" ";color:sp500_color;font.pointSize:32;font.family: font_style2}
        Text { Layout.fillWidth : true;renderType: Text.QtRendering;antialiasing : true;text: Market.sp500;color:font_color;font.pointSize:18;font.family: font_style2}
    }
}
Label {
        id: info4
        opacity: 0
        Layout.preferredWidth : 700
        Layout.alignment:Qt.AlignHCenter
     
     Grid {
         id:commidities_info
        columns: 5
        Layout.alignment:Qt.AlignHCenter
        y:-200
        x: 50
        Text {renderType: Text.QtRendering;antialiasing : true;text: "          Oil";color:font_color;font.bold:true;font.pointSize:18;font.family: font_style2}
        Text {renderType: Text.QtRendering;antialiasing : true;text: "                                              "}
        Text {renderType: Text.QtRendering;antialiasing : true;text: "  Gold";color:font_color;font.bold:true;font.pointSize:18;font.family: font_style2}
        Text {renderType: Text.QtRendering;antialiasing : true;text: "                                        "}
        Text {renderType: Text.QtRendering;antialiasing : true;text: "   10Y Yield";color:font_color;font.bold:true;font.pointSize:18;font.family: font_style2}
   }

    Grid {
        rows: 1
        spacing: 5
        y:-175
        x: 10
        topPadding: 10
        Layout.alignment:Qt.AlignHCenter
        Text {topPadding: -15;renderType: Text.QtRendering;antialiasing : true;text:oil_symbol;color:oil_color;font.pointSize:32;font.family: font_style2}
        Text {renderType: Text.QtRendering;antialiasing : true; text: Market.oil;color:font_color;font.pointSize:18;font.family: font_style2}
        Text {renderType: Text.QtRendering;antialiasing : true;color:font_color;font.bold:true;font.pointSize:18;font.family: font_style2;text:" | "}
        Text {topPadding: -15;renderType: Text.QtRendering;antialiasing : true;text:gold_symbol;color:gold_color;font.pointSize:32;font.family: font_style2}
        Text {renderType: Text.QtRendering;antialiasing : true; text: Market.gold;color:font_color;font.pointSize:18;font.family: font_style2}
        Text {renderType: Text.QtRendering;antialiasing : true;color:font_color;font.bold:true;font.pointSize:18;font.family: font_style2;text:" | "}
        Text {topPadding: -15;renderType: Text.QtRendering;antialiasing : true;text:y10_symbol;color:y10_color;font.pointSize:32;font.family: font_style2}
        Text {renderType: Text.QtRendering;antialiasing : true;text: Market.yield10;color:font_color;font.pointSize:18;font.family: font_style2}
     }
     }

ParallelAnimation {             //animate the info panes fade in and out
        running: true
        loops: Animation.Infinite
    
    SequentialAnimation {
        //running: true
        id:a1
       
       PauseAnimation { duration: 15000 }
        
        OpacityAnimator {
            target: info;
            from: 1;
            to: 0;
            duration: 1500
            //running: true
    }
       
        OpacityAnimator {
            target: info1;
            from: 0;
            to: 1;
            duration: 1000
            //running: true
    }
    
     PauseAnimation { duration: 15000}
       
        OpacityAnimator {
            target: info1;
            from: 1;
            to: 0;
            duration: 1000
            //running: true
    }
       
        OpacityAnimator {
            target: info2;
            from: 0;
            to: 1;
            duration: 1500
            //running: true
    }
    
     PauseAnimation { duration: 15000}
    
        OpacityAnimator {
            target: info2;
            from: 1;
            to: 0;
            duration: 1000
            //running: true
    }
    
        OpacityAnimator {
            target: info3;
            from: 0;
            to: 1;
            duration: 1500
            //easing.type: Easing.OutCirc
            //running: true
    }
    PauseAnimation { duration: 15000 }
    
        OpacityAnimator {
            target: info3;
            from: 1;
            to: 0;
            duration: 1000
            // easing.type: Easing.InCirc
            //running: true
    }
    
        OpacityAnimator {
            target: info4;
            from: 0;
            to: 1;
            duration: 1500
            // easing.type: Easing.OutCirc
            //running: true
    }
     PauseAnimation { duration: 15000}
    
        OpacityAnimator {
            target: info4;
            from: 1;
            to: 0;
            duration: 1000
            // easing.type: Easing.InCirc
            //running: true
    }
    
     
        OpacityAnimator {
            target: info;
            from: 0;
            to: 1;
            duration: 1500
            // easing.type: Easing.OutnCirc
            //running: true
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
