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

import QtQuick 2.8
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
    Layout.preferredWidth : 1500
    Layout.minimumWidth : 1500
    
    // readonly property bool softwareRendering: GraphicsInfo.api === GraphicsInfo.Software

    Label {
        // text: Qt.formatTime(timeSource.data["Local"]["DateTime"])
       // anchors.topMargin:200
        lineHeightMode: Text.FixedHeight
        lineHeight: 90
        topPadding : 50
        text: Qt.formatTime(timeSource.data["Local"]["DateTime"],"h:mm ap").replace("am", "").replace("pm", "")
        // color: ColorScope.textColor
        color: "whitesmoke"
       //  style: softwareRendering ? Text.Outline : Text.Normal
        // styleColor: softwareRendering ? ColorScope.backgroundColor : "transparent" //no outline, doesn't matter
        Layout.alignment: Qt.AlignHCenter
        renderType: Text.QtRendering
        font {
            pointSize: 72 //Mockup says this, I'm not sure what to do?
            family: "Noto Serif"
        }
    }
    Label {
        // text: Qt.formatDate(timeSource.data["Local"]["DateTime"], Qt.DefaultLocaleLongDate)
        text: Qt.formatDate(timeSource.data["Local"]["DateTime"],"dddd - MMMM  d")
        // color: ColorScope.textColor
        color: "whitesmoke"
        lineHeightMode: Text.FixedHeight
       lineHeight: 35
        Layout.alignment: Qt.AlignHCenter
        renderType: Text.QtRendering
        //style: softwareRendering ? Text.Outline : Text.Normal
        //styleColor: softwareRendering ? ColorScope.backgroundColor : "transparent" //no outline, doesn't matter
        font {
            pointSize: 28
            // family: config.displayFont
            family: "Noto Serif"
        }
    }
    
    Label {
        id:nday
        topPadding: 10
        text: Event.today
        color: "whitesmoke"
        // color: ColorScope.textColor
        antialiasing : true
             Layout.alignment: Qt.AlignHCenter
            renderType: Text.QtRendering
            lineHeightMode: Text.FixedHeight
            lineHeight: 20
            font {
            pointSize: 20 //Mockup says this, I'm not sure what to do?
            // family: config.displayFont
            family: "Noto Sans"
            italic:true
                }        
        }
        
        ToolSeparator {
            orientation:Qt.Horizontal
            Layout.fillWidth: true
            contentItem: Rectangle {
                // implicitWidth: parent.vertical ? 1 : 36
                implicitWidth: 400
                implicitHeight: parent.vertical ? 20 : 2
                color: "gray"
            }
        }
        
        Item {
            height:5
           // width: parent.width + 500
        }
     Label {
     id: info 
     Layout.alignment: Qt.AlignHCenter
     // renderType: Text.QtRendering
    
     Image {
       y: -45
       x: -360
       // horizontalAlignment: Image.AlignLeft
        // source: "/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/icons/weather-clouds.png"
        source : Weather.icon
        smooth: true
        sourceSize.width: 46
        sourceSize.height: 46
        }
           
        Text {
          y: -40
          x: -320
           // horizontalAlignment: Text.AlignLeft
              text: Weather.temp
              font.family: "Noto Sans"
              font.pointSize: 22
              font.capitalization: Font.Capitalize
              // font.bold:true
            color: "whitesmoke"
            // color: ColorScope.textColor
            antialiasing : true
        }
         Image {
        y: -40
        x: 280
        // horizontalAlignment: Image.AlignRight
       
        source: "/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/icons/email3.png"
        smooth: true
        sourceSize.width: 40
        sourceSize.height: 40
        }
      
      Text {
        y: -38
       x: 320
        text: Gmail.count
        // width: parent.width + 190
       // horizontalAlignment: Text.AlignRight
        font.family: "Noto Sans"
        font.bold:true
        font.pointSize:18
       // color: ColorScope.textColor
       color: "whitesmoke"
        antialiasing : true
    }
}


    Label {
     id: info2
      opacity: 0
    Layout.preferredWidth :400
    Layout.minimumWidth : 400
    Layout.alignment:Qt.AlignHCenter

       Grid {
    columns: 12
    // spacing: 120
    leftPadding: 10
    //rightPadding : 60
    // columnSpacing : 80
    topPadding: -80
    x: -130
    Layout.alignment:Qt.AlignHCenter
    Text { text: "   "}
    Text { text: Forecast.day0;color:"whitesmoke";font.bold:true;font.pointSize:16;font.family: "Noto Sans" }
    Text { text: "                   " }
    Text { text: Forecast.day1;color:"whitesmoke";font.bold:true;font.pointSize:16;font.family: "Noto Sans" }
    Text { text: "                   "}
    Text { text: Forecast.day2;color:"whitesmoke";font.bold:true;font.pointSize:16;font.family: "Noto Sans" }
    Text { text: "                  "}
    Text { text: Forecast.day3;color:"whitesmoke";font.bold:true;font.pointSize:16;font.family: "Noto Sans" }
    Text { text: "                  "}
    Text { text: Forecast.day4;color:"whitesmoke";font.bold:true;font.pointSize:16;font.family: "Noto Sans" }
    Text { text: "                  "}
     Text { text: Forecast.day5;color:"whitesmoke";font.bold:true;font.pointSize:16;font.family: "Noto Sans" }
  }
Grid {
    columns: 11
    columnSpacing : 10
    topPadding: -55
    leftPadding : 50
    // rightPadding : 70
    x: -140
    Layout.alignment:Qt.AlignHCenter
    
        Image {
        source : "../icons/blank.png"
        smooth: true
        sourceSize.width: 36
        sourceSize.height: 36
        }
        
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
    rows: 1
    rowSpacing : 5
    leftPadding : 80
    topPadding: 20
    x:-130
    Layout.alignment:Qt.AlignHCenter
    Text { text: Forecast.mintemp1;color:"whitesmoke";font.pointSize:16;font.family: "Noto Sans" }
    Text { text: "|";color:"whitesmoke";font.pointSize:14;font.family: "Noto Sans"}
    Text { text: Forecast.maxtemp1;color:"whitesmoke";font.pointSize:16;font.family: "Noto Sans" }
    Text { text: "              "}
    Text { text: Forecast.mintemp2;color:"whitesmoke";font.pointSize:16;font.family: "Noto Sans" }
    Text { text: "|";color:"whitesmoke";font.pointSize:14;font.family: "Noto Sans"}
    Text { text: Forecast.maxtemp2;color:"whitesmoke";font.pointSize:16;font.family: "Noto Sans" }
    Text { text: "           "}
    Text { text: Forecast.mintemp3;color:"whitesmoke" ;font.pointSize:16;font.family: "Noto Sans"}
    Text { text: "|";color:"whitesmoke";font.pointSize:14;font.family: "Noto Sans"}
    Text { text: Forecast.maxtemp3;color:"whitesmoke";font.pointSize:16;font.family: "Noto Sans" }
    Text { text: "          "}
    Text { text: Forecast.mintemp4;color:"whitesmoke" ;font.pointSize:16;font.family: "Noto Sans"}
    Text { text: "|";color:"whitesmoke";font.pointSize:14;font.family: "Noto Sans"}
    Text { text: Forecast.maxtemp4;color:"whitesmoke" ;font.pointSize:16;font.family: "Noto Sans"}
    Text { text: "           "}
    Text { text: Forecast.mintemp5;color:"whitesmoke" ;font.pointSize:16;font.family: "Noto Sans"}
    Text { text: "|";color:"whitesmoke";font.pointSize:14;font.family: "Noto Sans"}
    Text { text: Forecast.maxtemp5;color:"whitesmoke" ;font.pointSize:16;font.family: "Noto Sans"}
}
Grid {
    rows: 1
    spacing: 5
    leftPadding :80
    topPadding: 45
    x:-130
     Layout.alignment:Qt.AlignHCenter
      Text { text: "      "}
     Text { text: Forecast.rain1;color:"whitesmoke";font.pointSize:16;font.family: "Noto Sans"}
     Text { text: "               "}
     Text { text: Forecast.rain2;color:"whitesmoke";font.pointSize:16;font.family: "Noto Sans"}
     Text { text: "               "}
     Text { text: Forecast.rain3;color:"whitesmoke";font.pointSize:16;font.family: "Noto Sans"}
     Text { text: "                 "}
     Text { text: Forecast.rain4;color:"whitesmoke";font.pointSize:16;font.family: "Noto Sans"}
     Text { text: "                 "}
     Text { text: Forecast.rain5;color:"whitesmoke";font.pointSize:16;font.family: "Noto Sans"}
} 
     }
     
  Label {
     id: info3
      opacity: 0
       Layout.preferredWidth : 600
    Layout.minimumWidth : 600
           
   Grid {
    columns: 5
    Layout.alignment:Qt.AlignHCenter
    y:-120
    leftPadding :60
    Text { text: "         DOW";color:"whitesmoke";font.bold:true;font.pointSize:16;font.family: "Noto Sans"}
    Text { text: "                                            "}
    Text { text: "NASDAQ";color:"whitesmoke";font.bold:true;font.pointSize:16;font.family: "Noto Sans"}
    Text { text: "                                   "}
    Text { text: "S&P 500";color:"whitesmoke";font.bold:true;font.pointSize:16;font.family: "Noto Sans"}
   }
    
   Grid {
    rows: 1
    spacing: 5
    y:-100
   x: 15
   leftPadding :40
     Layout.alignment:Qt.AlignHCenter
     topPadding: 10
      Text { text: Market.dow;color:"whitesmoke";font.pointSize:18;font.family: "Noto Sans"}
      Text { text: Market.nasdaq;color:"whitesmoke";font.pointSize:18;font.family: "Noto Sans"}
      Text { text: Market.sp500;color:"whitesmoke";font.pointSize:18;font.family: "Noto Sans"}
    }
}
     Label {
     id: info4
      opacity: 0
       Layout.preferredWidth : 700
    Layout.minimumWidth : 700
     
     Grid {
    columns: 5
    Layout.alignment:Qt.AlignHCenter
    y:-160
    leftPadding :60
    Text { text: "         Oil";color:"whitesmoke";font.bold:true;font.pointSize:16;font.family: "Noto Sans"}
    Text { text: "                                             "}
    Text { text: "Gold";color:"whitesmoke";font.bold:true;font.pointSize:16;font.family: "Noto Sans"}
    Text { text: "                                    "}
    Text { text: "10Y Yield";color:"whitesmoke";font.bold:true;font.pointSize:16;font.family: "Noto Sans"}
   }
     
        Grid {
    rows: 1
    spacing: 15
     y:-140
     leftPadding :60
     topPadding: 10
     Layout.alignment:Qt.AlignHCenter
      Text { text: Market.oil;color:"whitesmoke";font.pointSize:18;font.family: "Noto Sans"}
      Text { text: Market.gold;color:"whitesmoke";font.pointSize:18;font.family: "Noto Sans"}
      Text { text: Market.yield10;color:"whitesmoke";font.pointSize:18;font.family: "Noto Sans"}
     }
     }
     ParallelAnimation {
        running: true
        loops: Animation.Infinite
    SequentialAnimation {
        running: true
        id:a1
       
       PauseAnimation { duration: 30000 }
        
        OpacityAnimator {
        target: info;
        from: 1;
        to: 0;
        duration: 1000
        // easing.type: Easing.InOutQuad
        running: true
    }
       
    OpacityAnimator {
        target: info2;
        from: 0;
        to: 1;
        duration: 1000
        // easing.type: Easing.OutInQuad
        running: true
    }
    
     PauseAnimation { duration: 30000}
    
    OpacityAnimator {
        target: info2;
        from: 1;
        to: 0;
        duration: 1000
        // easing.type: Easing.InOutQuad
        running: true
    }
    
    OpacityAnimator {
        target: info3;
        from: 0;
        to: 1;
        duration: 1000
        // easing.type: Easing.InOutQuad
        running: true
    }
    PauseAnimation { duration: 30000 }
    
    OpacityAnimator {
        target: info3;
        from: 1;
        to: 0;
        duration: 1000
        // easing.type: Easing.OutInQuad
        running: true
    }
    
    OpacityAnimator {
        target: info4;
        from: 0;
        to: 1;
        duration: 1000
        // easing.type: Easing.OutInQuad
        running: true
    }
     PauseAnimation { duration: 30000 }
    
     OpacityAnimator {
        target: info4;
        from: 1;
        to: 0;
        duration: 1000
        // easing.type: Easing.InOutQuad
        running: true
    }
    
     
    OpacityAnimator {
        target: info;
        from: 0;
        to: 1;
        duration: 1000
        // easing.type: Easing.InOutQuad
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
