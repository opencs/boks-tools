# OpenCS setpasswd

## Description

This script loads the list of IPs inside the file *bcastaddr* and tries to connect to them using on all ports used by BoKS using both TCP and UDP connections.

This script may be used to test the connections against a firewall and to exercise them in order to keep them alive in firewalls that close unused connections.

## Dependencies

This script requires the following tools to work:

   * A sh compatible shell (tested with **sh**);
   * passwd;
   * printf;
   * read;
   * test;

## Compatibility

This script should run on any **Linux** based systems and **IBM AIX** systems as well.
Other systems may be added to this list in the future.

## Installation

 1. Copy the file *setpasswd.sh* into the installation directory;
 1. Edit the file *setpasswd.sh* and fix the value of the variable **AUTHORIZED_USER** if the authorized user is not "root;

## Configuration

The configuration of this script contains the following parameters:

   * **AUTHORIZED_USER**: The user authorized to run this tool;

It is important to notice that this user must be a superuser or the command passwd will ask for the current 
user's password making leading to a failure in this script.

## Usage

In order to execute the tool:

1. Log in as the authorized user;
1. Execute *sh setpasswd.sh \<username\>*;
1. Type the new password followed by ENTER key;

It is important to notice that this program has no prompt, so type the password right
after the execution of the script.

## Limitations

   * This script cannot check if the authorized password can indeed execute **passwd** with root privileges;
   * This tool is not compatible with Windows hosts;

## Licensing

All tools inside this repository are licensed under BSD 3-Clause License.