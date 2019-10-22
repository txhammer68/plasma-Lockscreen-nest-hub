# Plasma Custom Lockscreen

## Modifications
* Display unread gmail messages count
* Current weather temp and conditions
* Calendar events from public web ical
* Hide clock and status info on kb/mouse movement
* Show login/password Ui on kb/mouse movement
* Enlarged user avatar and font
* Removed virtual keyboard, battery status

An attempt to get an android type lockscreen <br/>
Or what i learned using linux for 2 years. Skill level - Advanced <br/>
![Image of Lockscreen](lockscreen.gif)

### How it works:
kscreenlocker does not allow internet acesss, so this is a workaround using local files as JS variables <br/>
Modified Breeze plasma qml files to get the desired effects. Designed for 1920x1080 screens. <br/>
Using javacript node and python to create JS variables written to file system <br/>
The JS variables are used within qml losckreen files and systemd scripts to update them. <br/>
I am not a QML/QT expert, maybe someone with better skills could do this more efficently.

## Requirements:
* KDE Plasma 5.15, Node JS server, python3, systemd
* Node JS server - https://nodejs.dev/
* Weather function from https://github.com/nahidulhasan/nodejs-weather-app
* Python script for gmail https://github.com/akora/gmail-message-counter-python
* National Day Calendar - https://natdaycal.wordpress.com/
* Gmail Oauth https://developers.google.com/gmail/api/quickstart/python
* Plasma Look And Feel Explorer installed as plasma-sdk from your distro repo
* Some knowledge of node javascript,python,plasma qml files,linux systemd

### Installation at your own risk ;)  Backup original files so u can revert back.

* Extract all files to home directory / lockscreen
* From github - https://github.com/akora/gmail-message-counter-python modify for your inbox, setup Oauth credentials
   ** Modified to write to a file the unread mail count, add categories - updates, social, 
      use counter.py provided, instead of one from github
   ** See https://developers.google.com/gmail/api/quickstart/python for more info
* Install node js server within that folder
* Install node ical, fs, weather
* optional - modify natday1.js to your own public event calendar
* weather function from https://github.com/nahidulhasan/nodejs-weather-app - 
       modified to write to file, use provided index.js to get the file system write logic
* modify weather script for your city - 
   within the nodejs-weather-app-master folder edit index.js and change city name   
    const city = location || 'City Name, State USA';
* running within folder node weather will retrieve current temp for your city and create
   temp.js used as variable within Lockscreen.qml

### Plasma changes
_____________
Use Plasma Look And Feel Explorer installed as plasma-sdk to create a new Look and Feel Theme within 
/home/.local/share/plasma/look-and-feel/'Your Theme'
This is required as Breeze LnF theme has all the components needed to customize the Lockscreen.
Copy the folders from Breeze > /usr/share/plasma/look-and-feel/org.kde.breeze.desktop/contents/
to your new theme folder created above.

Use the qml files supplied to over-ride the default plasma ones // backup originals first
* edit the supplied Clock.qml and LockscreenUi.qml and change import statements for JS to path of your home directory
* import statments for gmail, weather in LockscreenUi.qml, calendar event in Clock.qml
* copy Clock.qml to /home/.local/share/plasma/look-and-feel/"Your Theme'/components/
* copy LockScreenUi.qml to /home/.local/share/plasma/look-and-feel/"Your Theme'/contents/lockscreen/
* copy MainBlock.qml  /home/.local/share/plasma/look-and-feel/"Your Theme'/contents/lockscreen/
* copy UserDelegate.qml /home/.local/share/plasma/look-and-feel/"Your Theme'/contents/components/
* copy WallpaperFader.qml  /home/.local/share/plasma/look-and-feel/"Your Theme'/contents/components/

Changes to qml files: <br/>
Modified Clock.qml to remove AMPM, as plasma only allows 24 hour clock or AMPM, added calendar event import variable <br/>
Modified LockscreenUi.qml to import javascript files as varibles, added dropshadow to header status area <br/>
  added effect to make clock and header status disappear / login info appear when mouse/kb movement detected <br/>
Modified UserDelegate.qml to remove circle around user avatar, enlarged avatar and font <br/>
Modified WallpaperFader.qml to make the clock and header status disappear when the mouse/kb movement detected.


### Systemd changes
_________
* Edit systemd service files to reflect location of node js scripts
* copy natday.service to /etc/systemd/system/       --used to fetch calendar events daily at 12:10 am
* copy natday.timer to /etc/systemd/system/         --used to fetch calendar events daily at 12:10 am
  * run sudo sudo systemctl start natday.service      --starts systemd service and timer
  * run sudo sudo systemctl start natday.timer      --starts systemd service and timer
  * run sudo sudo systemctl enable natday.service     --enables systemd service and timer
  * run sudo sudo systemctl enable natday.timer
* copy temp.service to /etc/systemd/system/        --used to fetch weather temperature daily every 60 mins
* copy temp.timer to /etc/systemd/system/          --used to fetch weather temperature daily every 60 mins
  * run sudo sudo systemctl start temp.service       --starts systemd service and timer
  * run sudo sudo systemctl start temp.timer       --starts systemd service and timer
  * run sudo sudo systemctl enable temp.service      --enables systemd service and timer
  * run sudo sudo systemctl enable temp.timer
* copy gmail.service to /etc/systemd/system/        --used to get gmail count daily every 60 mins
* copy gmail.timer to /etc/systemd/system/          --used to get gmail count daily every 60 mins
  * run sudo sudo systemctl start gmail.service       --starts systemd service and timer
  * run sudo sudo systemctl start gmail.timer       --starts systemd service and timer
  * run sudo sudo systemctl enable gmail.service      --enables systemd service and timer
  * run sudo sudo systemctl enable gmail.timer

### Testing
___________
* Test ical event info with > with node natday1.js  will retrieve calendar event and create <br/>
   natday.js variable file used in Clock.qml
* Test weather info with > node weather will retrieve temperature info and create temp.js <br/>
  variable file used in LockScreenUi.qml
* Test gmail count with python3 counter.py - use counter.py provided, <br/>
    will retrieve unread mail count info and create gmail.js 
* Test Lockscreen with /usr/lib/kscreenlocker_greet --testing --theme /home/.local/share/plasma/look-and-feel/'Your Theme'
* Verify SYSTEMD settings in System Settings  > SYSTEMD > TIMERS  - should be a description of the timers installed above.

### Notes
____________
* node js server required for js scripts
* ical, fs, weather-app install required to work
* using node JS functions and systemd to run the scripts at certain times to keep lockscreen current
* you must edit the qml files to reflect the location of these files, also the node JS files must be changed 
    to reflect the location to write the JS variable files

#### Node JS functions
* node natday1.js creates file called natday.js which is used in Clock.qml as a variable with import statement
* node weather creates file called temp.js which is used in LockscreenUi.qml as a variable with import statement

#### Python 3 functions
* python3 counter.py calls gmail to get unread mail messages and creates a file gmail.js  used in LockscreenUi.qml as a variable with import statement

* weather function from https://github.com/nahidulhasan/nodejs-weather-app - modified to write to file instead of console

* Info on weather temperature and gmail count displayed from before screen locked, 
   not sure how to update after screen locked.
* images used in status area are included, must change path within qml files to reflect location of images

### TODO:
_________
* update temp and email to update dynamically
* exract image metadata exif for description / location -- good for images from usplash/wallhaven/reddit earthporn
