## Systemd scripts to update the info used in clock.qml
_________
### Edit systemd service files to reflect location of the node js scripts
### Copy systemd .service and .timer files to /etc/systemd/system </br>
 ### Use systemctl to enable and start the services and timers
### Copy wakeup scripts to  /lib/systemd/system-sleep/ </br>
 ### These will execute when the system resumes from sleep mode </br>
 
Copy natday.service to /etc/systemd/system/       --used to fetch calendar events daily at 12:10 am
Copy natday.timer to /etc/systemd/system/         --used to fetch calendar events daily at 12:10 am
  sudo systemctl enable natday.service   --enables systemd service and timer
  sudo systemctl enable natday.timer
  sudo systemctl start natday.timer      --starts systemd service and timer
Copy temp.service to /etc/systemd/system/        --used to fetch weather temperature daily every 60 mins
Copy temp.timer to /etc/systemd/system/          --used to fetch weather temperature daily every 60 mins
 sudo systemctl enable temp.service    --enables systemd service and timer
 sudo systemctl enable temp.timer
 sudo systemctl start temp.timer
Copy forecast.service to /etc/systemd/system/     --used to update weather forecast every 8 hours
Copy forecast.timer to /etc/systemd/system/       --used to update weather forecast every 8 hours
 sudo systemctl enable forecast.service
 sudo systemctl enable forecast.time
 sudo systemctl start forecast.timer
Copy gmail.service to /etc/systemd/system/      --used to get gmail count daily every 60 mins
Copy gmail.timer to /etc/systemd/system/        --used to get gmail count daily every 60 mins
 sudo systemctl enable gmail.service    --enables systemd service and timer
 sudo systemctl enable gmail.timer
 sudo systemctl start gmail.timer
  
  
