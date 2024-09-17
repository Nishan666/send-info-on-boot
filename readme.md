# Send Mail on Ubuntu boot

To automatically send an email with system information (IP address, time, location, etc.) on Ubuntu boot, you can create a Bash script that integrates with your existing mail functionality. Then, set up a service or use cron to trigger this script when the system starts.

## Prerequisites

- Ubuntu 22.04 (or other Linux distributions)
- Git
- app password (update the app password (SMTP_PASSWORD) and email(SMTP_USER) and also the RECIPIENT)

#### Generate App password
- Sign in to your Google account 
- Click Security 
- Under Signing in to Google, click App Passwords 
- Click Select app and choose the app 
- Click Select device and pick the device you're using 
- Click Generate 
- Follow the instructions to enter the app password 
- Tap Done 

## Setup

1. Move the script to /usr/local/bin
```bash
sudo mv /path/to/send_info_on_boot.sh /usr/local/bin/send_info_on_boot.sh
```

2. Ensure proper permissions:
```bash
sudo chmod 700 /usr/local/bin/send_info_on_boot.sh
sudo chown root:root /usr/local/bin/send_info_on_boot.sh
```

3. Create a systemd service that triggers your script at boot.
```bash
sudo nano /etc/systemd/system/send-info-on-boot.service
```

4. Add the following content:

```bash
[Unit]
Description=Send system information email on boot
After=network.target

[Service]
ExecStart=/usr/local/bin/send_info_on_boot.sh
User=root
Environment="DISPLAY=:0"
Environment="XAUTHORITY=/run/user/1000/gdm/Xauthority"

[Install]
WantedBy=multi-user.target
```

5. Reload systemd and Enable the Service:
```bash
sudo systemctl daemon-reload
sudo systemctl enable send-info-on-boot.service
```



