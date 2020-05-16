## Systemd scripts to update the info used in clock.qml
_________
### Edit systemd service files to reflect location of the node js scripts
### Copy systemd .service and .timer files to /etc/systemd/system </br>
 ### Use systemctl to enable and start the services and timers
### Copy wakeup scripts to  /lib/systemd/system-sleep/ </br>
 ### These will execute when the system resumes from sleep mode </br>
 
Copy natday.service to /etc/systemd/system/       --used to fetch calendar events daily at 12:10 am </br>
Copy natday.timer to /etc/systemd/system/         --used to fetch calendar events daily at 12:10 am </br>
  sudo systemctl enable natday.service   --enables systemd service and timer </br>
  sudo systemctl enable natday.timer </br>
  sudo systemctl start natday.timer      --starts systemd service and timer </br>
Copy temp.service to /etc/systemd/system/        --used to fetch weather temperature daily every 60 mins </br>
Copy temp.timer to /etc/systemd/system/          --used to fetch weather temperature daily every 60 mins </br>
 sudo systemctl enable temp.service    --enables systemd service and timer </br>
 sudo systemctl enable temp.timer </br>
 sudo systemctl start temp.timer </br>
Copy forecast.service to /etc/systemd/system/     --used to update weather forecast every 8 hours </br>
Copy forecast.timer to /etc/systemd/system/       --used to update weather forecast every 8 hours </br>
 sudo systemctl enable forecast.service </br>
 sudo systemctl enable forecast.time </br>
 sudo systemctl start forecast.timer </br>
Copy gmail.service to /etc/systemd/system/      --used to get gmail count daily every 60 mins </br>
Copy gmail.timer to /etc/systemd/system/        --used to get gmail count daily every 60 mins </br>
 sudo systemctl enable gmail.service    --enables systemd service and timer </br>
 sudo systemctl enable gmail.timer </br>
 sudo systemctl start gmail.timer </br>
  
  
