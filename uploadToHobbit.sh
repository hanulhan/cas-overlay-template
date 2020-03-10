#!/bin/bash -eux
WEBAPP=cas

cd build
tar czf $WEBAPP.tar.gz ../etc/ libs/$WEBAPP.war
scp $WEBAPP.tar.gz uli@hobbit:~/CAS-OVERLAY-6
scp $WEBAPP.tar.gz uli@hobbit:~/CAS-OVERLAY-6/$WEBAPP-$(date +%Y-%m-%d).tar.gz
cd ..

