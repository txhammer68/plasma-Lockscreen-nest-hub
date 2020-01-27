import QtQuick 2.11
import QtQuick.Window 2.2
import QtQuick.Controls 2.4

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("FILE I/O TEST")
    color: "steelblue"

    function readTempFile(fileUrl){
       var xhr = new XMLHttpRequest;
       xhr.open("GET", fileUrl); // set Method and File
       xhr.onreadystatechange = function () {
           if(xhr.readyState === XMLHttpRequest.DONE){ // if request_status == DONE
               var response = xhr.responseText;

               read_txt.temp = response
           }
       }
       xhr.send(); // begin the request
   }

   function readDescFile(fileUrl){
       var xhr = new XMLHttpRequest;
       xhr.open("GET", fileUrl); // set Method and File
       xhr.onreadystatechange = function () {
           if(xhr.readyState === XMLHttpRequest.DONE){ // if request_status == DONE
               var response = xhr.responseText;

               read_txt.desc = response
           }
       }
       xhr.send(); // begin the request
   }
   function readIconFile(fileUrl){
       var xhr = new XMLHttpRequest;
       var icon0=""
       var icon1="01d.png"
       var icon2="01d.png"
       xhr.open("GET", fileUrl); // set Method and File
       xhr.onreadystatechange = function () {
           if(xhr.readyState === XMLHttpRequest.DONE){ // if request_status == DONE
               var response = xhr.responseText;

               type.icon1  = String(response)
               id2.icon2 = String(response)
           }
       }
       xhr.send(); // begin the request
   
   }
   
  Image {
       id:type
       asynchronous : true
      property string icon1:readIconFile("/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/icon.txt")
      //property string icon1:"../icons/50n.png"
      // source:"/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/icons//01n.png"
      // source:"../icons/01n.png"
      source:icon1
      cache: false
   }
   
   Text {
       id:id2
       y:80
       property string icon2:readIconFile("/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/icon.txt")
       text:icon2
       color:"white"
        font.pointSize: 14
   }
    Text {
        id:read_txt
        x:60
        y:10
        property var temp:readTempFile("/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/temp.txt")
        property var desc:readDescFile("/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/desc.txt")
        text:"  "+temp + desc
        color:"white"
        font.pointSize: 24
        font.capitalization: Font.Capitalize
    }
    
    Timer{
        id: readTemp
        interval: 10000
        running: true
        repeat:  true
        onTriggered: readTempFile("/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/temp.txt");
    }
    Timer{
        id: readDesc
        interval: 10000
        running: true
        repeat:  true
        onTriggered: readDescFile("/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/desc.txt");
    }
    Timer{
        id: readIcon
        interval: 10000
        running: true
        repeat:  true
        onTriggered: readIconFile("/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/icon.txt");
    }
}
