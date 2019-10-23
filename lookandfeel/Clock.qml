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
import "/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/natday.js" as Global
import "/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/temp.js" as Weather
import "/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/gmail.js" as Gmail

ColumnLayout {
    spacing : 20
    // readonly property bool softwareRendering: GraphicsInfo.api === GraphicsInfo.Software

    Label {
        // text: Qt.formatTime(timeSource.data["Local"]["DateTime"])
       lineHeightMode: Text.FixedHeight
        lineHeight: 100
        text: Qt.formatTime(timeSource.data["Local"]["DateTime"],"h:mm ap").replace("am", "").replace("pm", "")
        color: ColorScope.textColor
       //  style: softwareRendering ? Text.Outline : Text.Normal
        // styleColor: softwareRendering ? ColorScope.backgroundColor : "transparent" //no outline, doesn't matter
        Layout.alignment: Qt.AlignHCenter
        renderType: Text.QtRendering
        font {
            pointSize: 72 //Mockup says this, I'm not sure what to do?
            family: "Spectral"
        }
    }
    Label {
        // text: Qt.formatDate(timeSource.data["Local"]["DateTime"], Qt.DefaultLocaleLongDate)
        text: Qt.formatDate(timeSource.data["Local"]["DateTime"],"dddd - MMMM  d")
        color: ColorScope.textColor
        lineHeightMode: Text.FixedHeight
       lineHeight: 50
        Layout.alignment: Qt.AlignHCenter
        renderType: Text.QtRendering
        //style: softwareRendering ? Text.Outline : Text.Normal
        //styleColor: softwareRendering ? ColorScope.backgroundColor : "transparent" //no outline, doesn't matter
        font {
            pointSize: 36
            // family: config.displayFont
            family: "Spectral"
        }
    }
    
    Label {
        id:nday
        text: Global.today
        color: ColorScope.textColor
        antialiasing : true
             Layout.alignment: Qt.AlignHCenter
            renderType: Text.QtRendering
            lineHeightMode: Text.FixedHeight
            lineHeight: 20
            font {
            pointSize: 20 //Mockup says this, I'm not sure what to do?
            // family: config.displayFont
            family: "Spectral"
            italic:true
                }        
        }
        
        ToolSeparator {
            orientation:Qt.Horizontal
            Layout.fillWidth: true
            contentItem: Rectangle {
                implicitWidth: parent.vertical ? 1 : 24
                implicitHeight: parent.vertical ? 20 : 1
                color: "gray"
            }
        }
        
        Item {
            height:1
        }
     Label {
     id: info 
     Layout.alignment: Qt.AlignHCenter
     renderType: Text.QtRendering
     // lineHeightMode: Text.FixedHeight
     // text: "15"
     // y: -100
     Image {
        id: gmail
       //  y:300
       y: -30
       x: -180
        source: "/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/icons/email3.png"
        smooth: true
        sourceSize.width: 40
        sourceSize.height: 40
        }
        
        Text {
           y: -30
           x: -140
              text: Gmail.count
              font.family: "Roboto"
              font.pointSize: 20
            color: ColorScope.textColor
            antialiasing : true
        }
        
         Image {
        id: weather1
        y: -30
           x: 50
        source: "/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/icons/weather-clouds.png"
        smooth: true
        sourceSize.width: 48
        sourceSize.height: 48
        }
      
      Text {
        y: -30
        x: 100
        text: Weather.temp
        font.family: "Roboto"
        font.pointSize: 20
       color: ColorScope.textColor
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
