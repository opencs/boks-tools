# OpenCS boks-ping.sh

## Description

This script loads the list of IPs inside the file *bcastaddr* and tries to connect to them using on all ports used by BoKS using both TCP and UDP connections.

This script may be used to test the connections against a firewall and to exercise them in order to keep them alive in firewalls that close unused connections.

## Dependencies

This script requires the following tools to work:

   * A csh compatible shell (tested with **dash**);
   * cat;
   * grep;
   * sed;
   * sort;
   * uniq;
   * nc;

## Installation

 1. Copy the files *boks-ping.sh* and *boks-ping.cfg* into the installation directory;
 1. Make the file *boks-ping.sh* executable;
 1. Edit the file *boks-ping.cfg* and fix the location of the files if required;

## Configuration

The configuration file contains only 3 parameters:

   * BCASTADDR_FILE: The location of the file **bcastaddr** (default: /etc/opt/boksm/bcastaddr);
   * SERVICES_FILE: The **/etc/services** file to be used. The tool will look for the service called **boks** in order to find the current base port used by BoKS;
   * BOKS_DEFAULT_PORT: The default BoKS port if it was not found inside **/etc/services**;

## Usage

In order to execute the tool, just run the script *boks-ping.sh*. The activities of the tool will be reported directly into the stdin.

## Limitations

   * The response to UDP messages are not verified because BoKS will discard them;
   * This tool is not compatible with Windows hosts;

## Licensing

All tools inside this repository are licensed under BSD 3-Clause License.