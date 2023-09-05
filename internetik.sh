#!/bin/sh
#


nmcli d && \
nmcli r wifi on && \
nmcli d wifi list && \
nmcli d wifi connect Telia-F491E5-Greitas password 16446B2348
