#!/bin/bash 
if [ $(docker ps -q -f name="cas" ) ]; then
    echo "vorhanden"
else
    echo "nicht vorhanden"
fi

