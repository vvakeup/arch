#!/bin/sh
#

INFOFILE="$HOME/info/usefulcmd"
NOTE=$1
DESCRIPTION=$2

if [[ $# -eq 0 ]] ; then
    echo "Empty strings are not allowed!"
    exit 1
fi

if [[ -z "$2" && $NOTE == "edit" ]] ; then
    nvim $INFOFILE
    echo "Open notes for editing."
    exit 1
fi

if [ -z "$2" ] ; then
    echo -e "\n##\n$NOTE" >> $INFOFILE
    echo "New line append:"
    cat $INFOFILE | tail -1
else
    cat <<EOF >> $INFOFILE

# $DESCRIPTION:
$NOTE
EOF
    echo "New line with description append:"
    cat $INFOFILE | tail -2
fi
