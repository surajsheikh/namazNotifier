#!/bin/bash
sudo apt-get update
sudo apt-get install python3 notify-osd python3-pip python3-tk at git
sudo pip3 install termcolor
sudo apt-get install sox
sudo apt-get install sox libsox-fmt-all
rm -rf /tmp/NamazNotifier
sudo rm -rf /etc/namaznotifier/
sudo mkdir /etc/namaznotifier/
sudo touch /etc/namaznotifier/namaznotifier.dict
sudo chmod 666 /etc/namaznotifier/namaznotifier.dict
sudo chmod 777 /etc/namaznotifier/
git clone https://surajsheikh:ca29066e4c937ee42bdbfbd7028dfe4534d14e41@github.com/surajsheikh/NamazNotifier.git /tmp/NamazNotifier

sudo cp /tmp/NamazNotifier/NamazNotifier.py /bin
sudo cp /tmp/NamazNotifier/resources/namaz.png /etc/namaznotifier/
sudo cp /tmp/NamazNotifier/resources/notification.mp3 /etc/namaznotifier/
sudo chmod 555 /bin/NamazNotifier.py

#write out current crontab
crontab -l > mycron
#echo new cron into cron file
pyt=`which python3`
grep -v 'NamazNotifier' mycron > mycront
#Below configuration are needed, otherwise notify send doesnt work from cro
echo "@reboot echo 'sudo -u $USER DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/`id -u`/bus $pyt /bin/NamazNotifier.py' | at now + 2 minutes" >> mycront
echo "15 0 * * * sudo -u $USER DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/`id -u`/bus $pyt /bin/NamazNotifier.py" >> mycront

#install new cron file
crontab mycront
rm mycron
rm mycront

$pyt /bin/NamazNotifier.py manual
$pyt /bin/NamazNotifier.py


#sudo -u $USER DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus /usr/bin/notify-send -u critical -t 60000 "SOund" "sound" && paplay /usr/share/sounds/freedesktop/stereo/service-login.oga
