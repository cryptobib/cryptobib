#!/bin/sh

# Generate mrconfig configuration files from mrconfig_tmpl template

sed -e 's%\$baseurl%https://github.com/cryptobib%' < mrconfig_tmpl > mrconfig_https
sed -e 's%\$baseurl%git@github.com:cryptobib%' < mrconfig_tmpl > mrconfig_ssh
