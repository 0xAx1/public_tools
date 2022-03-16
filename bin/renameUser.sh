#! /bin/bash 


while :; do
    case $1 in
        -h|-\?|--help)
            echo "renameUser.sh oldname newname "    # Display a usage synopsis.
            exit
            ;;
	*)              
            break
            ;;
    esac
done

exec sudo -i
killall -u $1
id $1
usermod -l $2 $1
groupmod -n $2 $1
usermod -d /home/$2 -m $2
usermod -c "[full name (new)]" $2 
id $2
