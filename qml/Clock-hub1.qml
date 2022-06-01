import QtQuick 2.9
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.5
import org.kde.plasma.core 2.0

// clock hub info
Item {
    id:root
    width:600
    height:500
    property var font_color:"black"         // change font color
    property var font_style1:"Noto Serif"   // change clock font
    property var font_style2:"Noto Sans"    // change info status font

    property var url2:"https://api.openweathermap.org/data/2.5/onecall?lat=29.64&lon=-95.02&units=imperial&appid=5819a34c58f8f07bc282820ca08948f1"
    //property var url2:"/Data/projects/QML/weather/OpenWeather/onecall.json"

    property var url3:"/tmp/gmail.txt"
    property var weather:{}
    property var index:{}
    property var gmail:0
    property int today:Qt.formatDate(timeSource.data["Local"]["DateTime"],"MMdd")


    property var nth:getOrdinal(Qt.formatDate(timeSource.data["Local"]["DateTime"],"d"))

    function getOrdinal(n) {            // assigns superfix to date
            var s=["th","st","nd","rd"],
            v=n%100;
            return (s[(v-20)%10]||s[v]||s[0]);
        }

 property var events:{
        0101:"🎊 New Year's Day",
        0105:"🎂 Goodies Birthday",
        0116:"🎂 Mom's Birthday",
        0117:"🎂 Chuck Coxie's Birthday",
        0121:"🎂 Johnny Taylor's Birthday",
        0202:"🦫 Groundhog Day",
        0211:"🎂 Dad's Birthday",
        0214:"💘 Valentine's Day",
        0220:"🎂 Travis Mitchell's Birthday",
        0221:"🇺🇸 Presidents' Day",
        0301:"🎉 Mardi Gras!",
        0302:"🎂 Joe Childers's III Birthday",
        0311:"🎂 Zach Taylor's Birthday",
        0315:"🎂 Earl Estep's Birthday",
        0317:"🍀 St. Patricks day",
        0318:"🎂 Katie Taylor's Birthday",
        0322:"🎂 Kathy Clark's Birthday",
        0401:"April Fools' Day",
        0413:"🎂 Nick Taylor's Birthday",
        0417:"Easter",
        0422:"♻ Earth Day",
        0428:"🎂 Bridget Hemmeline's Birthday",
        0504:"🎂 Chase Taylor's Birthday",
        0504:"🔫 May the Force be With You",
        0505:"🇲🇽 Cinco De Mayo",
        0530:"🇺🇸 Memorial Day",
        0614:"🇺🇸 Flag Day",
        0619:"🍺 Father's Day",
        0623:"🎂 David Mounts's Birthday",
        0704:"🇺🇸 Independence Day",
        0805:"🎂 Jennifer Taylor's Birthday",
        0809:"🎂 Natalie Taylor's Birthday",
        0904:"🎂 Sheri McNiel's Birthday",
        0905:"🇺🇸 Labor Day",
        0906:"🎂 Christine Guidroiz's Birthday",
        0911:"🇺🇸 September 11th (Patriot Day)",
        0920:"🎂 Paul Jr.'s Birthday",
        0921:"🎂 Diane Tweedle's Birthday",
        0923:"🎂 Misty Guidroz's Birthday",
        1003:"🎂 Murline Staley's Birthday",
        1009:"🎂 Brad,Nathan,Brenda Taylor's Birthdays",
        1026:"🎂 Cindy Mitchell's Birthday",
        1031:"🎃 Halloween",
        1124:"🦃 Thanksgiving Day",
        1124:"🎂 Paul Clark's III Birthday",
        1212:"🎂 Geoff Simon's III Birthday",
        1216:"🎂 Andrew Taylor's Birthday",
        1222:"🎂 Lynda Taylor's Birthday",
        1224:"🎅🏻 Christmas Eve",
        1225:"🎄 Christmas Day",
        1231:"🎊 New Years Eve"
    }

    function getData(fileUrl){  // read icon code from file
        var xhr = new XMLHttpRequest;
        xhr.open("GET", fileUrl); // set Method and File
        xhr.onreadystatechange = function () {
            if(xhr.readyState === XMLHttpRequest.DONE){ // if request_status == DONE
                var response = xhr.responseText;
                if (fileUrl===url3) {
                    gmail=response}
                    else if (fileUrl===url2) {
                        weather=JSON.parse(response) }
            }
        }
        xhr.send(); // begin the request
    }

    Column {
            id:c1
            anchors.horizontalCenter: root.horizontalCenter
            spacing:2

        Text {
        id:time
        topPadding : 70
        text: Qt.formatTime(timeSource.data["Local"]["DateTime"],"h:mm ap").replace("am", "").replace("pm", "")
                                                                                // removes am,pm
        color: font_color
        antialiasing : true
        font.pointSize: 72
        font.family: font_style1
        }

        Text {
        id:date
        textFormat: Text.RichText
        text: Qt.formatDate(timeSource.data["Local"]["DateTime"],"dddd - MMMM  d")+"<sup>"+nth+"</sup>"
        // html markup for superfix date
        color: font_color
        antialiasing : true
        font.pointSize: 28
        font.family: font_style1
        }

    Text {
        id:calEvents
        textFormat: Text.RichText
        text:events[today]
        height: (events[today] === undefined) ? 1 : 20
        visible:(events[today] === undefined) ? false : true
        color: font_color
        antialiasing : true
        font.pointSize: 16
        font.family: font_style1
        }

        Component.onCompleted: {
        for (var item in children)
            children[item].anchors.horizontalCenter = c1.horizontalCenter;
        }

        ToolSeparator {
        id:ts
        orientation:Qt.Horizontal
        Layout.fillWidth: true
        contentItem: Rectangle {
            implicitWidth: 600
            implicitHeight: 2
            color: "gray"
            antialiasing : true
        }
    }
    }

    Item {
        id:info
        anchors.top:c1.bottom
        anchors.left:c1.left
        anchors.right:c1.right
        Layout.preferredWidth :620
        opacity:1
        Row {
            id:r1
            leftPadding:20
            spacing:20

            Image {
                id: wIcon
                asynchronous : true
                cache: false
                source: "../icons/"+weather.current.weather[0].icon+".png"
                smooth: true
                sourceSize.width: 64
                sourceSize.height: 64
            }

            Text {
                id:current_weather_conditions
                Layout.fillWidth: false
                topPadding:15
                text:Math.round(weather.current.temp)+"°   "+weather.current.weather[0].main
                font.family: font_style2
                font.pointSize: 18
                font.capitalization: Font.Capitalize
                textFormat: Text.RichText
                color: font_color
                antialiasing : true
            }
        }
        Row {
            anchors.right:parent.right
            // anchors.left:date.left
            rightPadding:20
            topPadding:10
            spacing:10
            Image {
                id:email_icon
                source: "../gmail.png"
                smooth: true
                sourceSize.width: 36
                sourceSize.height: 36
            }

            Text {
                id:email_count
                text: gmail
                font.family: font_style2
                font.pointSize:16
                color: font_color
                antialiasing : true
            }
        }
    }

    Item {
        id:info2
        anchors.top:c1.bottom
        anchors.left:c1.left
        anchors.right:c1.right
        Layout.preferredWidth :620
        anchors.leftMargin:5
        opacity:0

        Column {
            id:forecast
            topPadding:10
            visible:true
            spacing:1
            leftPadding:80

            Row {
                spacing:60
                Repeater {
                    model: 5
                    Text {
                        text:Qt.formatDate(new Date(weather.daily[index].dt*1000)," ddd ")
                        color:"black"
                        font.pointSize:14
                    }
                }
            }


            Row {
                spacing:49
                Repeater {
                    model: 5
                   Image {
                    source:"../icons/"+weather.daily[index].weather[0].icon+".png"
                    width:48
                    height:48
                }
                }
            }

            Row {
                spacing:5
                leftPadding:10
                Repeater {
                    model: 5
                   Text {
                        property var x1:Math.round((weather.daily[index].pop*100/10)*10).toString().length
                        text:Math.round(weather.daily[index].pop*100/10)*10+"% "
                        color:"black"
                        width:x1+92
                        Layout.fillWidth:true
                        font.pointSize:12
                    }
                }
            }

             Row {
                spacing:5
                Repeater {
                    model: 5
                   Text {
                    text: Math.round(weather.daily[index].temp.min)+"°"+"|"+Math.round(weather.daily[index].temp.max)+"°"
                    color:"black"
                    font.pointSize:12
                    Layout.fillWidth:true
                    width:92
                }
                }
            }
        }
    }

    Item {
        id:info3
        anchors.top:c1.bottom
        anchors.left:c1.left
        anchors.right:c1.right
        Layout.preferredWidth :620
        visible:true
        opacity:0
        anchors.leftMargin:100

        Astros{}
    }


     ParallelAnimation {
        running: true
        loops: Animation.Infinite
        SequentialAnimation {
            running: true
            loops: Animation.Infinite
            id:a1

            PauseAnimation { duration: 5000 }

            OpacityAnimator {
                target: info;
                from: 1;
                to: 0;
                duration: 1000
            }

            OpacityAnimator {
                target: info2;
                from: 0;
                to: 1;
                duration: 1000
            }

            PauseAnimation { duration: 5000}

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
                duration: 1000
            }

            PauseAnimation { duration: 5000}

            OpacityAnimator {
                target: info3;
                from: 1;
                to: 0;
                duration: 1000
            }

            OpacityAnimator {
                id:lastAi
                target: info;
                from: 0;
                to: 1;
                duration: 1000
            }
            PauseAnimation { duration: 5000}
        }
    }

    DataSource {
        id: timeSource
        engine: "time"
        connectedSources: ["Local"]
        interval: 1000
    }

Timer{                  // timer to trigger update for weather info
        id: readFiles
        interval: 20* 60 * 1000 // every 20 minutes
        running: true
        repeat:  true
        triggeredOnStart:true
        onTriggered: {
            getData(url3)
            getData(url2)
            getData(url1)
        }
    }
}
