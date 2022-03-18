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


usermod --login $2 --move-home --home /home/$2 $1
groupmod --new-name $2 $1 

