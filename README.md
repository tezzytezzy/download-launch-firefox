# The Latest Firefox Downloader (UNIX/LINUX) #

This script:    

1. Downloads the latest Firefox from the official FTP site in tar.bz2 per [README.txt](https://ftp.mozilla.org/pub/firefox/releases/latest/README.txt), and    
2. Launches it in private mode.    

### Background ###

I could not install Linux Mint properly one day even after the installation finished with the “Please remove installation medium” message. 

I could not manage to resurrect the Mint even with rescue live ISOs e.g. [SystemRescue](https://www.system-rescue.org/), [Rescatux](https://www.supergrubdisk.org/rescatux/) and [UNetbootin](https://unetbootin.github.io/)

The SystemRescue 10.01 comes with the minimal Xfce (4.18) in its bootable live USB, so I decided to use it as my everyday OS for a while.

All I want to do is browse the Web so the pre-installed Firefox (102.11.0esr (64-bit)) is useful.

Unforunately, [Slack](https://slack.com/) complained with a message “This browser won’t be supported starting September 1st, 2023.” (At that time, the latest Firefox version was 116.0.2)

### Files ###

* download_launch_firefox.sh
* config.ini (optional, for setting up Time Zone and WIFI)

### Instructions ###

Download the download_launch_firefox.sh and issue `/bin/bash ./download_launch_firefox.sh` on your Terminal.

### Tested Environments ###
```bash
[root@sysrescue ~]# bash --version
GNU bash, version 5.1.16(1)-release (x86_64-pc-linux-gnu)

tezzy@HP:~/Desktop$ bash --version
GNU bash, version 4.4.20(1)-release (x86_64-pc-linux-gnu)
```

### Output ###
```bash
[root@sysrescue ~]# /bin/bash ./download_launch_firefox.sh 
Checking config.ini...
Config.ini not found. Skipping Time Zone and WIFI set up.
Downloading the compressed latest Firefox files...
--2023-08-13 16:02:58--  https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US
Resolving download.mozilla.org (download.mozilla.org)... 52.38.164.252, 44.228.65.146, 35.167.248.51
Connecting to download.mozilla.org (download.mozilla.org)|52.38.164.252|:443... connected.
HTTP request sent, awaiting response... 302 Found
Location: https://download-installer.cdn.mozilla.net/pub/firefox/releases/116.0.2/linux-x86_64/en-US/firefox-116.0.2.tar.bz2 [following]
--2023-08-13 16:02:58--  https://download-installer.cdn.mozilla.net/pub/firefox/releases/116.0.2/linux-x86_64/en-US/firefox-116.0.2.tar.bz2
Resolving download-installer.cdn.mozilla.net (download-installer.cdn.mozilla.net)... 34.117.35.28
Connecting to download-installer.cdn.mozilla.net (download-installer.cdn.mozilla.net)|34.117.35.28|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 76509228 (73M) [application/x-tar]
Saving to: ‘FirefoxSetup.tar.bz2’

                                      100%[========================================================================>]  72.96M  4.58MB/s    in 17s     

2023-08-13 16:03:15 (4.39 MB/s) - ‘FirefoxSetup.tar.bz2’ saved [76509228/76509228]

Extracting the files...
Launching Firefox in private mode...
ATTENTION: default value of option mesa_glthread overridden by environment.
ATTENTION: default value of option mesa_glthread overridden by environment.
ATTENTION: default value of option mesa_glthread overridden by environment.
```

### FAQ ###
1. Do I have to `chmod 744 ./download_launch_firefox.sh` before `/bin/bash ./download_launch_firefox.sh`?    
No need. Running a shell script using `/bin/bash` merely reads and interprets the input file: executing `bash`, which resolves to the program /bin/bash, reads the file and executes its code. On the other hand, file permissions have an effect in executing a file via syscall (`exec`). See [this](https://askubuntu.com/questions/25681/can-scripts-run-even-when-they-are-not-set-as-executable).

### Afterthoughts ###
* Ubuntu's `/bin/sh` has long been replaced with `/bin/dash`. This might break a shell script and this is why I use `bash`, instead of `sh`. See [this](https://wiki.ubuntu.com/DashAsBinSh).
* `Bash` is a superset of `sh`. See [this](https://www.geeksforgeeks.org/difference-between-sh-and-bash/).
