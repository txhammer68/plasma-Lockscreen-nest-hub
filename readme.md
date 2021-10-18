# Custom Plasma Lockscreen
## Modifications
* Display unread gmail messages count, current weather conditions and forecast, stock market index's
* Calendar events - birthdays/holidays
* Using qml animation timers to show current weather conditions, forecast, and stock market index's
* kb/mouse movement, hide clock and status info, show login/password Ui <br/>
Click image for a short video demo
[![Plasma Lockscreen](lockscreen.png)](https://user-images.githubusercontent.com/9554887/137651273-b48f7208-2461-436c-b146-abd574601509.mp4)


### How it works:
For security reasons, kscreenlocker does not allow internet acesss, 
Using javacript node and python to create JS variables written to file system <br/>
The JS variables are used within qml locksreen files and systemd scripts to update them. <br/>
Modified Breeze plasma qml files to get the desired effects. Designed for 1920x1080 screens. <br/>

## Requirements:
* Some knowledge of linux, node javascript,python,plasma qml files
* KDE Plasma 5.15, Linux 4.x kernel w/ systemd, Node JS server, python3 <br/>
* [Node JS](https://nodejs.dev/) <br/>
* [Python](https://www.python.org/download/releases/3.0/) <br/>
* Weather data:
     * [Weather Conditions](https://github.com/nahidulhasan/nodejs-weather-app) <br/>
      * [OpenWeather](https://openweathermap.org/api) <br/>
      * [Weather.com](https://weather.com/swagger-docs/call-for-code) <br/>
      * [Accuweather](https://developer.accuweather.com/) <br/>
      * [weather.gov](https://www.weather.gov/documentation/services-web-api) <br/>

* [National Day Calendar](https://natdaycal.wordpress.com/) <br/>
* Stock Market info from CNN Money - 'node install cnn-market' <br/>
* [Python script for gmail](https://github.com/akora/gmail-message-counter-python)
* [Gmail Oauth](https://developers.google.com/gmail/api/quickstart/python)
* [Plasma Look And Feel Explorer installed as plasma-sdk from your distro repo](
      https://userbase.kde.org/Plasma/Create_a_Look_and_Feel_Package)

### Installation process. Backup original files so u can revert back.

* Extract all files to home directory / lockscreen <br/>
* Extract MyBreeze.zip to $HOME/.local/share/plasma/look-and-feel/ <br/>
   ** Custom Breeze theme for testing the qml and JS script <br/>
* Change global theme to new MyBreeze theme <br/>
  ** test lockscreen with <br/>
      /usr/lib/kscreenlocker_greet --testing --theme $HOME/.local/share/plasma/look-and-feel/MyBreeze   <br/>
 * Read [install.md](install.md) for detailed installation steps

