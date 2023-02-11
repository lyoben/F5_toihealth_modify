#!/bin/bash

def_main() {

filename="toihealth_$USER"

echo -e "\nCopying /usr/local/bin/toihealth  --->  /home/$USER/bin/\n"

cp /usr/local/bin/toihealth /home/$USER/bin/$filename

file="/home/$USER/bin/$filename"

if [ -f "$file" ]
then
    echo -e "\nChanging to your credentials"

    sed -i '29 i import base64' $file
    sed -i '207 s/default/#default/' $file
    echo -e "."

    sed -i "208 i \                default_username = \"$username\"" $file
    echo -e ".."

    sed -i '233 s/password/#password/' $file
    echo -e "..."

    sed -i "234 i \                encoded_password = \"$encoded_password\"" $file
    sed -i "235 i \                password = base64.b64decode(encoded_password).decode(\"utf-8\")" $file

    echo -e "\nDone. $file is written with your credentials"
    echo -e "\nexiting...\n" ; sleep 2 ; exit
else
    echo -e "\n$file nout found, exiting..." ; sleep 2 ; exit
fi

}

echo -e "\n==================================================="
echo -e "Modify toihealth script to your own credentials"
echo -e "===================================================\n"

while read -p "Your support.f5.com username (eg: xxx@f5.com): " username ; do
    if [ "$username" != "" ]; then break; fi
done

echo -n "Password: " ; read password

echo -e "\nYou have entered:-\nUsername: $username\nPassword: $password"

encoded_password=$(echo -n $password | base64)

while true; do
read -p "Please ensure correct credentials and confirm if you want to proceed (y/n)? " yn
    sleep 0.5
    case $yn in
        [Yy]* ) sleep 0.5 ; def_main; break;;
        [Nn]* ) echo -e "\nexiting now..." ; sleep 2 ; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done





