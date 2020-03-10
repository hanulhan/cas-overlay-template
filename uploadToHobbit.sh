#!/bin/bash -eux
WEBAPP=cas

cd target
tar czf $WEBAPP.tar.gz ../etc $WEBAPP.war
scp $WEBAPP.tar.gz uli@hobbit:~/CAS-OVERLAY-5
scp $WEBAPP.tar.gz uli@hobbit:~/CAS-OVERLAY-5/$WEBAPP-$(date +%Y-%m-%d).tar.gz
cd ..

