## LockScreen setup
#### Most themes do not include qml code for lockscreen/logout, etc. so Plasma reverts back to the Breeeze defaults. <br>
#### To enable a custom lockscreen/logout theme
Copy the default global theme Breeze `/usr/share/plasma/look-and-feel/`
to MyBreeze within `$HOME/.local/share/plasma/look-and-feel/MyBreeze`
Then within the new MyBreeze
    copy the Clock.qml to the components folder in the new MyBreeze theme folder
    copy icons to `$HOME/.local/share/plasma/look-and-feel/MyBreeze/contents/icons
    copy LockscreenUI.qml to the lockscreen folder in the new MyBreeze theme folder
    
   ## Tools
    * Python for G-Mail inbox authorization, yahoo finance api for stocks, espn api for sports
   
   ## G-Mail
  * [google developer](https://developers.google.com/gmail/api/quickstart/python)
  * [github](https://github.com/akora/gmail-message-counter-python)
    ** Modified to write to a file the unread mail count, add categories - updates, social, 
        use counter.py provided, instead of one from github

## Stock Market Index
   * Edit qml code to add/remove stock indexes
    
### Testing 
___________
* Change global theme to new MyBreeze theme <br/>
  ** test lockscreen with <br/>
      /usr/lib/kscreenlocker_greet --testing --theme $HOME/.local/share/plasma/look-and-feel/MyBreeze   <br/>
* Test gmail count with python3 counter.py - use counter.py provided, <br/>
    will retrieve unread mail count info and create gmail.js 
* Test Lockscreen with /usr/lib/kscreenlocker_greet --testing --theme $HOME/.local/share/plasma/look-and-feel/MyBreeze

#### Python 3 functions
* python3 counter.py calls gmail to get unread mail messages and creates a file gmail.js  used in Clock.qml as a variable with import statement
