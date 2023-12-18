#!/bin/bash

TO_TEAM=$1
ALERT_TYPE=$2
BODY=$3
TO_ADDRESS=$4
SUBJECT=$5

FINAL_BODY=$(sed -e 's/TO_TEAM/$TO_TEAM/g' -e 's/ALERT_TYPE/$ALERT_TYPE/g' -e 's/BODY/$BODY/g' template.html)

echo "$FINAL_BODY" | mail -s "$(echo -e "$SUBJECT\nContent-Type: text/html")" "$TO_ADDRESS"
