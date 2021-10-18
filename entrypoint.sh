#! /bin/bash
set -e

echo "Connecting to wireguard server"
wg-quick up /ampr.conf

echo "IP Address Dump"
ip a
ping 44.31.62.1 -c 3
ping 44.0.0.1 -c 3

echo "Starting HTTP server"
lighttpd -D -f /etc/lighttpd/lighttpd.conf &

echo "Starting the proxy"
java -jar /EchoLinkProxy.jar /ELProxy.conf

echo "Shutting down wireguard"
wg-quick down /ampr.conf
