#enable sar 
sudo apt install sysstat -y
cd "$( dirname "${BASH_SOURCE[0]}" )"

sudo cp sysstat /etc/default/
sudo systemctl restart sysstat.service

# limit logis size
sudo cp logrotate.conf  /etc/
