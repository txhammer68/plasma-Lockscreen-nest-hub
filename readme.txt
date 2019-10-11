Lockscreen update readme

a good hack job to get temp and calendar events on the lockscreen
OR What i learned using linux for 2 years..

How it works:
kscreenlocker does not allow internet acesss, so this is a workaround using local files as js variables
Modified plasma qml files to get the desired effects.
I am a not a QML/QT expert, maybe someone with better skills could do this more efficently...

***** Installation at your own risk ;)  Backup original files so u can revert back if dont like or does not work ********

> uses node js functions for both calendar and temperature functions
> uses node fs to create js variable files used in qml lockscreen files
> calendar events from public ical National Day, but could use any web access public calendar
> edit nat-day1.js to change url for calendar of your choice
> using node js functions and systemd to run the scripts at certain times to keep lockscreen current

Extract all files to home directory folder lockscreen
install node js server within that folder
install node ical, fs, weather
    weather function from https://github.com/nahidulhasan/nodejs-weather-app - modified to write to file instead of console
    modify ical js to your own public event calendar
    modify weather script for your city - 
        within the nodejs-weather-app-master folder edit index.js and change city name   // const city = location || 'City Name, State USA';
        running within folder node weather will retrieve current temp for your city and create temp.js used as variable within Lockscreen.qml

Plasma changes
===========================================================================
within the /usr/share/plasma/look-and-feel/org.kde.breeze.desktop folders
use the qml files supplied to over-ride the default plasma ones // backup originals first...
edit both Clock.qml and LockscreenUi.qml and change import statements fir JS to path of download or home directory
copy Clock.qml to /usr/share/plasma/look-and-feel/org.kde.breeze.desktop/contents/components/
copy LockScreenUi.qml to /usr/share/plasma/look-and-feel/org.kde.breeze.desktop/contents/lockscreen/
copy MainBlock.qml  /usr/share/plasma/look-and-feel/org.kde.breeze.desktop/contents/lockscreen/
copy UserDelegate.qml /usr/share/plasma/look-and-feel/org.kde.breeze.desktop/contents/components/
copy WallpaperFader.qml  /usr/share/plasma/look-and-feel/org.kde.breeze.desktop/contents/components/


Systemd changes
==========================================================================
edit systemd service files to reflect location of node js scripts
copy natday.service to /etc/systemd/system/  // used to fetch calendar events daily at 12:10 am
copy natday.timer to /etc/systemd/system/     // used to fetch calendar events daily at 12:10 am
run sudo sudo systemctl start natday.service    // starts systemd service and timer
run sudo sudo systemctl enable natday.service   // enables systemd service and timer
run sudo sudo systemctl enable natday.timer

copy temp.service to /etc/systemd/system/  // used to fetch weather temperature daily every 30 mins
copy temp.timer to /etc/systemd/system/  // used to fetch weather temperature daily every 30 mins
run sudo sudo systemctl start temp.service    // starts systemd service and timer
run sudo sudo systemctl enable temp.service    // enables systemd service and timer
run sudo sudo systemctl enable temp.timer

==========================================================================
Testing

1. Test ical event info with > node js ical with node natday1.js  will retrieve calendar event and create natday.js variable file used in Clock.qml
2. Test weather info with > node weather will retrieve temperature info and create temp.js variable file used in LockScreenUi.qml
3. Test Lockscreen with /usr/lib/kscreenlocker_greet --testing --theme /usr/share/plasma/look-and-feel/org.kde.breeze.desktop
4. Verify SYSTEMD settings in System Settings  > SYSTEMD > TIMERS  - should be a description of the two timers installed above.

==========================================================================
NOTES:
node js server required for js scripts
ical, fs, weather-app install required to work
using node js functions and systemd to run the scripts at certain times to keep lockscreen current
weather function from https://github.com/nahidulhasan/nodejs-weather-app - modified to write to file instead of console
natday.js is used in Clock.qml as js variable to print the National Day calendar events - this file is updated from the systemd service/timer events
natday1.js is used as node js to get the calendar event info
temp.js   is used in LockscreeUi.qml as variable to print the current temperature  - this file is updated from the systemd service/timer events
node weather is used to get current weather temp info  - edit weather - index.js for city info and location to create variable file
you must edit the qml files to reflect the location of these files, also the node js files must be changed 
    to reflect the location to write the js variable files

    i have a restore script that copies the qml files back after an KDE Plasma update, as they over written after an update, 
    optional is to create a new theme and use these files within that theme folders to avoid being over written when updated
    sudo cp /run/media/hammer/Data/projects/LockScreenUi.qml /usr/share/plasma/look-and-feel/org.kde.breeze.desktop/contents/lockscreen/
    sudo cp /run/media/hammer/Data/projects/Clock.qml /usr/share/plasma/look-and-feel/org.kde.breeze.desktop/contents/components/
===================================================================================================
Optional
There is a tool called Plasma Look And Feel Explorer installed as plasma-sdk from your repos distro
this will allow you to create your own LookandFeel Theme avoiding updates by Plasma which overwrite the default Breeze theme.
What i did was copy the contents of Breeze from lookandfeel within /usr/share/plasma/look-and-feel/org.kde.breeze.desktop/contents/ to
    create a new folder with my theme name within /home/.local/share/plasma/look-and-feel/
    then run Plasma Look And Feel Explorer and create new theme, fill in the info and click use current theme settings, this will apply your current Plasma look to your new theme
    Save the theme in the folder you created above.
    
    goto System Settings - >LookandFeel your theme should be there, try it out 
        if you go this route change the above to reflect the location of this LookandFeel folders instead of the default ones....

TODO:
update temp variable to update dynamically, current only display temp from before screen locked
get email count - requires oauth for gmail security
