#!/bin/sh
# boks-ping.sh - A tool to 'ping' all BoKS hosts using nc
# Copyright (c) 2017 Open Communications Security. All rights reserved.
# This script was released under the terms of 

# Get the script
CURR_DIR=$(pwd)
SCRIPT_HOME=$(dirname $0)
cd "$SCRIPT_HOME"
SCRIPT_HOME=$(pwd)
cd "$CURR_DIR"

# Load the configuration file
. "$SCRIPT_HOME/boks-ping.cfg"

#-------------------------------------------------------------------------------
# Recovers a list of ports associated with a given service.
# Usage: get_port_from_services
get_port_from_services() {
	if [ -f "$SERVICES_FILE" ]; then
		port=$(cat "$SERVICES_FILE" | grep "^boks[[:space:]]" | grep "tcp" | sed 's/[a-z][a-z]*[^0-9]*//' | sed 's/\/.*//' | sort)
	fi
	if [ -z "$port" ]; then
		printf "$BOKS_DEFAULT_PORT"
	else
		printf "$port"
	fi
}

#-------------------------------------------------------------------------------
# Loads the list of IPs from "bcastaddr".
# Usage: load_ips
load_ips() {
	if [ -f "$BCASTADDR_FILE" ]; then
		cat "$BCASTADDR_FILE" | grep -v "ADDRESS_LIST" | grep -v "SECONDARY_ADDRESS_LIST" | uniq
	fi
}

#-------------------------------------------------------------------------------
# Sends a dummy UDP to a given server and port.
# Usage: send_udp <address/ip> <port>
send_udp() {
	echo "dummy" | nc -w 1 -u $1 $2
}

#-------------------------------------------------------------------------------
# Sends an empty message through TCP to a given server and port.
# Usage: send_tcp <address/ip> <port>
send_tcp() {
	echo "" | nc -w 15 $1 $2
}

#-------------------------------------------------------------------------------
# Pings a host using a TCP and UDP connection.
# Usage: ping_host <address/ip> <port>
ping_host() {
	printf "Pinging BoKS host $1 on port $2 using UDP..."
	if send_udp "$1" "$2"; then
		echo "OK"
	else
		echo "FAIL"
	fi
	printf "Pinging BoKS host $1 on port $2 using TCP..."
	if send_tcp "$1" "$2"; then
		echo "OK"
	else
		echo "FAIL"
	fi
}

#-------------------------------------------------------------------------------
# Main
echo "boks-ping.sh - A tool to 'ping' all BoKS hosts using nc"
echo "Copyright (c) 2017 Open Communications Security. All rights reserved."
echo ""
echo "Loading services from $SERVICES_FILE"
base_port=$(get_port_from_services)
echo "Loading IPs from $BCASTADDR_FILE"
ip_list=$(load_ips)
if [ -z "$ip_list" ]; then
	echo "Unable to load the file $BCASTADDR_FILE."
	exit 1
fi

# Excute the ping
for ip in $ip_list; do
	ping_host $ip $base_port
	ping_host $ip $(($base_port + 1))
	ping_host $ip $(($base_port + 2))
	ping_host $ip $(($base_port + 3))
done
echo "Done!"

