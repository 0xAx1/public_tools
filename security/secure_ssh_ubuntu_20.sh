#! /bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

current_location=$(pwd)

echo "username (will be created with sudo groups and ssh access): "
read username

echo "user cert (ED25519 public key):"
read user_cert

echo "ssh port (avoid 22):"
read ssh_port

apt update 
apt upgrade -y

apt install -y sudo 
mv /etc/ssh/sshd_config /etc/ssh/sshd_config_save

cd "$( dirname "${BASH_SOURCE[0]}" )"
cp ./sshd_config /etc/ssh/

echo "Port $ssh_port" >> /etc/ssh/sshd_config 
echo "AllowUsers $username"  >> /etc/ssh/sshd_config

echo "1/ setting a new root secure pwd"
passwd
echo "2/ setting a new pwd for $username user (same pwd is fine)"
adduser  --gecos "" $username
usermod -aG sudo $username
usermod -aG adm $username
usermod -aG systemd-journal $username

mkdir /home/$username/.ssh
echo "$user_cert" > /home/$username/.ssh/authorized_keys
chown $username:$username -R /home/$username/.ssh/
chmod 700 /home/$username/.ssh/
chmod 600 /home/$username/.ssh/authorized_keys

cp /etc/ssh/moduli /etc/ssh/moduli_save

echo "3/ generating new moduli. It might take a while..."
ssh-keygen -M generate -O bits=2048 moduli-2048.candidates
ssh-keygen -M screen -f moduli-2048.candidates moduli-2048
cp moduli-2048 /etc/ssh/moduli
rm moduli-2048*

systemctl restart sshd

apt-get install fail2ban -y
echo "[sshd]" >> /etc/fail2ban/jail.local
echo "enabled = true"  >> /etc/fail2ban/jail.local
echo "port    = $ssh_port"  >> /etc/fail2ban/jail.local

service fail2ban restart

sudo apt install ufw -y


sudo ufw allow $ssh_port
yes | sudo ufw enable

echo "ssh has been secured"
echo "!!! KEEP THIS CONNECTION ALIVE  and double check that only $username can login now"

cd $current_location
