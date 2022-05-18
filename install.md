## LockScreen setup
#### Most themes do not include qml code for lockscreen/logout, etc. so Plasma reverts back to the Breeeze defaults. <br>
#### To enable a custom lockscreen/logout theme
Copy the default global theme Breeze `/usr/share/plasma/look-and-feel/`
to MyBreeze within `$HOME/.local/share/plasma/look-and-feel/MyBreeze`
* Included is a MyBreeze theme for testing, but this is how u can create your own

    
   ## Tools
    * Python for G-Mail inbox authorization, yahoo finance api for stocks, espn api for sports
   
   ## G-Mail
  * [google developer](https://developers.google.com/gmail/api/quickstart/python)
  * [github](https://github.com/akora/gmail-message-counter-python)
    ** Modified to write to a file the unread mail count, add categories - updates, social, 
        use counter.py provided, instead of one from github

## Stock Market Index
   * Edit qml code to add/remove stock indexes

## Weather
   * Edit qml code to change lat/lon for weather location
    
### Testing 
___________
* Change global theme to new MyBreeze theme <br/>
  ** test lockscreen with <br/>
      /usr/lib/kscreenlocker_greet --testing --theme $HOME/.local/share/plasma/look-and-feel/MyBreeze   <br/>
* Test gmail count with python3 counter.py - use counter.py provided, <br/>
    will retrieve unread mail count info and create gmail.js 
* Test Lockscreen with /usr/lib/kscreenlocker_greet --testing --theme $HOME/.local/share/plasma/look-and-feel/MyBreeze

#### Python 3 functions
* python3 counter.py calls gmail to get unread mail messages and creates a file gmail.js  used in Clock.qml
