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
import "/run/media/hammer/Data/projects/natday.js" as Global

ColumnLayout {
    readonly property bool softwareRendering: GraphicsInfo.api === GraphicsInfo.Software

    Label {
        // text: Qt.formatTime(timeSource.data["Local"]["DateTime"])
        text: Qt.formatTime(timeSource.data["Local"]["DateTime"],"h:mm ap").replace("am", "").replace("pm", "")
        color: ColorScope.textColor
       //  style: softwareRendering ? Text.Outline : Text.Normal
        // styleColor: softwareRendering ? ColorScope.backgroundColor : "transparent" //no outline, doesn't matter
        font {
            pointSize: 80 //Mockup says this, I'm not sure what to do?
            family: "Spectral"
        }
        lineHeightMode: Text.FixedHeight
        lineHeight: 120 
        Layout.alignment: Qt.AlignHCenter
        renderType: Text.QtRendering
    }
    Label {
        // text: Qt.formatDate(timeSource.data["Local"]["DateTime"], Qt.DefaultLocaleLongDate)
        text: Qt.formatDate(timeSource.data["Local"]["DateTime"],"dddd - MMMM  d")
        color: ColorScope.textColor
        //style: softwareRendering ? Text.Outline : Text.Normal
        //styleColor: softwareRendering ? ColorScope.backgroundColor : "transparent" //no outline, doesn't matter
        font {
            pointSize: 36
            // family: config.displayFont
            family: "Spectral"
        }
        Layout.alignment: Qt.AlignHCenter
        renderType: Text.QtRendering
    }
    
    Label {
        id:nday
        text: Global.today
        color: ColorScope.textColor
        antialiasing : true
             Layout.alignment: Qt.AlignHCenter
            renderType: Text.QtRendering
            font {
            pointSize: 20 //Mockup says this, I'm not sure what to do?
            // family: config.displayFont
            family: "Spectral"
            italic:true
                }        
        }
    
    DataSource {
        id: timeSource
        engine: "time"
        connectedSources: ["Local"]
        interval: 1000
    }
}
