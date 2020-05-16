## Plasma changes
_____________
Use Plasma Look And Feel Explorer installed as plasma-sdk to create a new Look and Feel Theme within 
/home/.local/share/plasma/look-and-feel/'Your Theme'

This is required as Breeze LnF theme has all the components needed to customize the Lockscreen.
Copy the folders from Breeze > /usr/share/plasma/look-and-feel/org.kde.breeze.desktop/contents/
to your new theme folder created above.

### Within the Clock.qml edit import statements to refelct location of Js scripts

Clock.qml - import "../code/natday.js" as Event<br/>
Clock.qml - import "../code/gmail.js" as Gmail<br/>
Clock.qml - import "../code/market.js" as Market<br/>
Clock.qml - import "../code/forecast.js" as Forecast<br/>

### Use the qml files supplied to over-ride the default plasma ones // backup originals first
* edit the supplied Clock.qml and LockscreenUi.qml and change import statements for JS to path of your home directory
* import statments for gmail, weather,stocks in Clock.qml
* copy Clock.qml to /home/.local/share/plasma/look-and-feel/"Your Theme'/components/
* copy LockScreenUi.qml to /home/.local/share/plasma/look-and-feel/"Your Theme'/contents/lockscreen/
* copy MainBlock.qml  /home/.local/share/plasma/look-and-feel/"Your Theme'/contents/lockscreen/
* copy UserDelegate.qml /home/.local/share/plasma/look-and-feel/"Your Theme'/contents/components/
* copy WallpaperFader.qml  /home/.local/share/plasma/look-and-feel/"Your Theme'/contents/components/

### Changes to qml files: <br/>
Modified Clock.qml to remove AMPM, as plasma only allows 24 hour clock or AMPM, added calendar event import variable <br/>
Modified LockscreenUi.qml  to make clock and header status disappear / login info appear when mouse/kb movement detected <br/>
Modified UserDelegate.qml to remove circle around user avatar, enlarged avatar and font <br/>
Modified WallpaperFader.qml to make the clock and header status disappear when the mouse/kb movement detected.
