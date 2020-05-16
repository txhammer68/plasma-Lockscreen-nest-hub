## Systemd changes
_________
* Edit systemd service files to reflect location of node js scripts
* copy wakeup scripts to  /lib/systemd/system-sleep/ </br>
  * These will execute when the system resumes from sleep mode </br>

* Copy systemd .service and .timer files to /etc/systemd/system </br>
  * Use systemctl to enable and start the services and timers
  
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
  * run sudo sudo systemctl start gmail.timer       --starts systemd service and timer
  * run sudo sudo systemctl enable gmail.service      --enables systemd service and timer
  * run sudo sudo systemctl enable gmail.timer
  
  
