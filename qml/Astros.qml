import QtQuick 2.8
import QtQuick.Controls 2.15
import org.kde.plasma.components 2.0
import org.kde.plasma.core 2.0
import QtQuick.Layouts 1.1

//astros mlb scoes

Item {
    id:root
    width:500
    height:120
    property var url1:"http://site.api.espn.com/apis/site/v2/sports/baseball/mlb/scoreboard"
    property var scores:{}
    property var key:0
    /// Object.keys(index.events).length  // array size

    function getOrdinal(n) {            // assigns superfix to date
        var s=["th","st","nd","rd"],
        v=n%100;
        return (s[(v-20)%10]||s[v]||s[0]);
        }
        property var nth:getOrdinal(Qt.formatDate(timeSource.data["Local"]["DateTime"],"d"))

    function getData(url){  // get data json api scores
        var xhr = new XMLHttpRequest;
        xhr.open("GET", url); // set Method and File  true=asynchronous
        xhr.onreadystatechange = function () {
            if(xhr.readyState === XMLHttpRequest.DONE){ // if request_status == DONE
                var response = xhr.responseText;
                scores=JSON.parse(response)
            }
        }
        xhr.send(); // begin the request
    }

    Component.onCompleted: {
        getData(url1);
       // findKey();
    }
        function findKey() {  // find astros

            for (var i = 0; i < Object.keys(scores.events).length; i++) {

                if (scores.events[i].competitions[0].competitors[0].team.displayName==="Houston Astros")  {
                    //tx1.text=scores.events[i].competitions[0].competitors[0].team.displayName
                    key=i
                    val=0

            }
         else if (scores.events[i].competitions[0].competitors[1].team.displayName==="Houston Astros")  {
              //tx1.text=scores.events[i].competitions[0].competitors[1].team.displayName
             key=i
             val=1
         }
            }
        }

        Row {
            id:game
            spacing:10
            topPadding:10
            leftPadding:20

            Image {
                source:scores.events[key].competitions[0].competitors[1].team.logo
                width:48
                height:48
                smooth:true

                MouseArea {
                id: mouseArea1a
                anchors.fill: parent
                cursorShape:  Qt.PointingHandCursor
                hoverEnabled:true
                //onEntered:warnings ? alerts.color="Steelblue": alerts.color="white"
                //onExited:warnings ? alerts.color="yellow" : alerts.color="white"
                onClicked: {
                Qt.openUrlExternally(scores.events[key].competitions[0].competitors[1].team.links[0].href)
                }
            }
            }
            Text {
                id:tm1
                text:scores.events[key].competitions[0].competitors[1].team.abbreviation
                color:"black"
                font.pointSize:16
                width:60
                Layout.fillWidth:true

            MouseArea {
                            id: mouseArea1
                            anchors.fill: parent
                            cursorShape:  Qt.PointingHandCursor
                            hoverEnabled:true
                            //onEntered:warnings ? alerts.color="Steelblue": alerts.color="white"
                            //onExited:warnings ? alerts.color="yellow" : alerts.color="white"
                            onClicked: {
                            Qt.openUrlExternally(scores.events[key].links[0].href)
                            }
                        }
            }

            Text {
                id:score1
                text:scores.events[key].competitions[0].competitors[1].score
                color:"black"
                font.pointSize:16
                width:30
                Layout.fillWidth:true

                MouseArea {
                id: mouseArea2
                anchors.fill: parent
                cursorShape:  Qt.PointingHandCursor
                hoverEnabled:true
                //onEntered:warnings ? alerts.color="Steelblue": alerts.color="white"
                //onExited:warnings ? alerts.color="yellow" : alerts.color="white"
                onClicked: {
                Qt.openUrlExternally(scores.events[key].links[0].href)
                }
            }
            }

            Text {
                id:inning
                text:scores.events[key].competitions[0].status.type.completed ?  scores.events[key].competitions[0].status.type.detail :scores.events[key].competitions[0].status.period+getOrdinal(scores.events[key].competitions[0].status.period)
                //scores.events[key].competitions[0].status.type.detail
                color:"black"
                font.pointSize:12
                topPadding:5
            }
        Text {
                text:" "
                color:"black"
                font.pointSize:16
        }
            Image {
                source:scores.events[key].competitions[0].competitors[0].team.logo
                width:42
                height:42
                smooth:true

                MouseArea {
                id: mouseArea3a
                anchors.fill: parent
                cursorShape:  Qt.PointingHandCursor
                hoverEnabled:true
                //onEntered:warnings ? alerts.color="Steelblue": alerts.color="white"
                //onExited:warnings ? alerts.color="yellow" : alerts.color="white"
                onClicked: {
                Qt.openUrlExternally(scores.events[key].competitions[0].competitors[0].team.links[0].href)
                }
            }
            }
            Text {
                id:tm2
                text:scores.events[key].competitions[0].competitors[0].team.abbreviation
                color:"black"
                font.pointSize:16
                width:60
               Layout.fillWidth:true

               MouseArea {
                id: mouseArea3
                anchors.fill: parent
                cursorShape:  Qt.PointingHandCursor
                hoverEnabled:true
                //onEntered:warnings ? alerts.color="Steelblue": alerts.color="white"
                //onExited:warnings ? alerts.color="yellow" : alerts.color="white"
                onClicked: {
                Qt.openUrlExternally(scores.events[key].links[0].href)
                }
            }
            }

            Text {
                id:score2
                text:scores.events[key].competitions[0].competitors[0].score
                color:"black"
                font.pointSize:16
                width:30
               Layout.fillWidth:true

MouseArea {
                id: mouseArea4
                anchors.fill: parent
                cursorShape:  Qt.PointingHandCursor
                hoverEnabled:true
                //onEntered:warnings ? alerts.color="Steelblue": alerts.color="white"
                //onExited:warnings ? alerts.color="yellow" : alerts.color="white"
                onClicked: {
                Qt.openUrlExternally(scores.events[key].links[0].href)
                }
            }
            }
        }
    Row {
        id:rec
        anchors.top:game.bottom
        anchors.horizontalCenter:game.horizontalCenter;
        spacing:1
        topPadding:-19

        Text {
            id:rec1
            text:"       ("+scores.events[key].competitions[0].competitors[1].records[0].summary+")"
            color:"gray"
            font.pointSize:10
            //leftPadding:60

        }

        Text {
            id:d1
            text:Qt.formatDateTime(scores.events[key].competitions[0].date,"   M/d/yy")+"\t              "
            color:"gray"
            font.pointSize:10
            leftPadding:60
        }

        Text {
            id:rec0
            text:"("+scores.events[key].competitions[0].competitors[0].records[0].summary+")"
            color:"gray"
            font.pointSize:10
        }
    }

Row {
    anchors.top:rec.bottom
    anchors.horizontalCenter:game.horizontalCenter;
    topPadding:5

    Text {
        text:scores.events[key].competitions[0].headlines[0].shortLinkText
        color:"black"
        font.pointSize:12
        leftPadding:15

MouseArea {
                id: mouseArea5
                anchors.fill: parent
                cursorShape:  Qt.PointingHandCursor
                hoverEnabled:true
                //onEntered:warnings ? alerts.color="Steelblue": alerts.color="white"
                //onExited:warnings ? alerts.color="yellow" : alerts.color="white"
                onClicked: {
                Qt.openUrlExternally(scores.events[key].links[0].href)
                }
            }
    }
}

        Timer{
            id: t1
            interval: 400
            running: true
            repeat:  false
            onTriggered: {
                findKey();
            }
        }
}
