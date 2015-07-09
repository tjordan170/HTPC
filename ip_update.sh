#!/bin/bash
# create old_ip file if it does not exist
touch old_ip

# fetch current ip address
curl ipecho.net/plain > current_ip

# read previous and current ip addresses
read IP1 <current_ip
read IP2 <old_ip

# sometimes curl doesn't retrieve current ip which causes problems

# skip if current_ip variable is empty
if [ -z "$IP1" ]
then
    echo "No IP retrieved."

# check to see if old and current ips are the same
elif [ "$IP1" = "$IP2" ]
then
    echo "IP address has not changed."

# send email if ips are different
else
(echo "From: [ENTER_YOUR_FROM_GMAIL_ADDRESS]"; echo "To: [ENTER_YOUR_TO_EMAIL_ADDRESS]"; echo "Subject: IP Address Update"; echo; echo "Your IP address has changed. The new IP is:"; cat current_ip) | msmtp --from=default -t [ENTER_YOUR_TO_EMAIL_ADDRESS] --file=/etc/msmtprc
    echo "IP address has changed."

# clean up files and store current_ip as old_ip
rm old_ip
mv current_ip old_ip

fi
