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

ColumnLayout {
    spacing : 20
    // Layout.preferredWidth : 500
    Layout.minimumWidth : 900
    // readonly property bool softwareRendering: GraphicsInfo.api === GraphicsInfo.Software

    Label {
        // text: Qt.formatTime(timeSource.data["Local"]["DateTime"])
       
        lineHeightMode: Text.FixedHeight
        lineHeight: 90
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
       lineHeight: 50
        Layout.alignment: Qt.AlignHCenter
        renderType: Text.QtRendering
        //style: softwareRendering ? Text.Outline : Text.Normal
        //styleColor: softwareRendering ? ColorScope.backgroundColor : "transparent" //no outline, doesn't matter
        font {
            pointSize: 36
            // family: config.displayFont
            family: "Noto Serif"
        }
    }
    
    Label {
        id:nday
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
                implicitWidth: 600
                implicitHeight: parent.vertical ? 20 : 2
                color: "whitesmoke"
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
       x: -300
       // horizontalAlignment: Image.AlignLeft
        // source: "/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/icons/weather-clouds.png"
        source : Weather.icon
        smooth: true
        sourceSize.width: 46
        sourceSize.height: 46
        }
        
        Text {
          y: -40
          x: -255
           // horizontalAlignment: Text.AlignLeft
              text: Weather.temp
              font.family: "Noto Sans"
              font.pointSize: 18
              font.capitalization: Font.Capitalize
              // font.bold:true
            color: "whitesmoke"
            // color: ColorScope.textColor
            antialiasing : true
        }
         Image {
        y: -40
        x: 230
        // horizontalAlignment: Image.AlignRight
       
        source: "/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/icons/email3.png"
        smooth: true
        sourceSize.width: 40
        sourceSize.height: 40
        }
      
      Text {
        y: -40
       x: 275
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
        
    
    DataSource {
        id: timeSource
        engine: "time"
        connectedSources: ["Local"]
        interval: 1000
    }
}
