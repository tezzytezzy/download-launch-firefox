#! /bin/bash

# All variables in bash are global by default
# Global variables should be in ALL_CAPITAL_CASE with readonly designation 
# Variable substitution within a string should be "${variable}", NOT just $variable
# REFERENCE: https://google.github.io/styleguide/shellguide.html
# Use https://www.shellcheck.net/ for linting


function get_script_directory() {
  #`declare` stipulates a variable as "local" by default. `-r` makes it readonly
  declare -r SCRIPT_PATH="${BASH_SOURCE:-$0}" # e.g. ./thisscript.sh   
  declare -r FULL_SCRIPT_PATH="$(realpath "${SCRIPT_PATH}")" # e.g. /home/to/thisscript.sh
  
  echo "$(dirname "${FULL_SCRIPT_PATH}")" # e.g. /home/to
}

SCRIPT_DIRECTORY=$(get_script_directory)
readonly SCRIPT_DIRECTORY

CONFIG_FILE="${SCRIPT_DIRECTORY}/config.ini"
readonly CONFIG_FILE

echo "Checking config.ini..."

if [ -f "${CONFIG_FILE}" ]; then
  # TIME_ZONE, WIFI_DEVICE, WIFI_SSID & WIFI_PASSPHRASE are specified in config.ini
  # Use process substitution `<()`
  # shellcheck source=/usr/bin/grep
  source <(grep '=' "${CONFIG_FILE}")

  echo "Setting up Time Zone..."
  timedatectl set-timezone "${TIME_ZONE}"

  echo "Setting up WIFI..."
  if command -v iwctl > /dev/null 2>&1; then
    iwctl device list
    iwctl station "${WIFI_DEVICE}" scan
    iwctl station "${WIFI_DEVICE}" get-networks
    iwctl --passphrase="${WIFI_PASSPHRASE}" station "${WIFI_DEVICE}" connect "${WIFI_SSID}"
  else
    echo "iNet wireless daemon (iwd) not found. Skipping WIFI setup."
  fi  
else
  echo "Config.ini not found. Skipping Time Zone and WIFI set up."
fi

FIREFOX_TAR_FILE=FirefoxSetup.tar.bz2
readonly FIREFOX_TAR_FILE

echo "Downloading the compressed latest Firefox files..."
wget -P "${SCRIPT_DIRECTORY}" -O "${FIREFOX_TAR_FILE}" "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US"

# Bash script executes line by line synchronously, so no need to explicitly wait for the above file download to complete before the file extraction below
echo "Extracting the files..."
tar xfC "${SCRIPT_DIRECTORY}/${FIREFOX_TAR_FILE}" "${SCRIPT_DIRECTORY}"

echo "Launching Firefox in private mode..."
"${SCRIPT_DIRECTORY}"/firefox/firefox -private-window

# TODO(tezzy): Make the Terminal calling this script close itself in `sh ./download_launch_firefox.sh`
# The followings were tried and failed:
# `nohup ./download_launch_firefox.sh &` (upon running)
# `kill -9 $PPID` (end of this script)
# `source exit 0` (end of this script)
