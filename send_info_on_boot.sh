#!/bin/sh

# Variables
RECIPIENT="jackxdotedge@gmail.com"
SMTP_SERVER="smtp.gmail.com"
SMTP_PORT="587"
SMTP_USER="*************"
SMTP_PASSWORD="*********"

# Get the public IP address
IP_ADDRESS=$(curl -s ifconfig.me)

# Get the current time
CURRENT_TIME=$(date "+%Y-%m-%d %H:%M:%S")

# Get the username
USERNAME=$(whoami)

# Get location information based on IP (using ipinfo.io)
LOCATION=$(curl -s https://ipinfo.io/$IP_ADDRESS | grep -E 'city|region|country' | tr -d '"',)

# Get battery percentage (for Linux systems)
BATTERY_PERCENTAGE=$(acpi -b | grep -P -o '[0-9]+(?=%)')

# Compose the message
MESSAGE="Your current IP address is: $IP_ADDRESS
Time: $CURRENT_TIME
Username: $USERNAME
Location: $LOCATION
Battery Percentage: $BATTERY_PERCENTAGE%"

# Send the email using s-nail
echo "$MESSAGE" | s-nail -v -s "System Info on Boot, Time: $CURRENT_TIME" \
    -S smtp="$SMTP_SERVER:$SMTP_PORT" \
    -S smtp-auth=login \
    -S smtp-auth-user="$SMTP_USER" \
    -S smtp-auth-password="$SMTP_PASSWORD" \
    -S smtp-use-starttls \
    $RECIPIENT
