#!/bin/bash -x

WEBAPP=cas.war
DOCKER_DIR=/home/uli/docker/cas6
PROJECT_DIR=/home/uli/Projekte/AcenticCAS/Server/cas-overlay-template

cd $DOCKER_DIR
if [ $(docker ps -q -f name="cas" ) ];
then
   docker-compose down
fi

rm $DOCKER_DIR/tomcat/cas/logs/*
if [ -d $DOCKER_DIR/tomcat/cas/etc/cas/ ];
then
   rm -fr $DOCKER_DIR/tomcat/cas/etc/cas/*
fi
cp -r $PROJECT_DIR/etc/cas $DOCKER_DIR/tomcat/cas/etc

if [ -d $DOCKER_DIR/tomcat/cas/webapps/cas ];
then
   rm -fr $DOCKER_DIR/tomcat/cas/webapps/cas
fi
if [ -f $DOCKER_DIR/tomcat/cas/webapps/$WEBAPP ];
then
   rm $DOCKER_DIR/tomcat/cas/webapps/$WEBAPP
fi

cp $PROJECT_DIR/build/libs/$WEBAPP $DOCKER_DIR/tomcat/cas/webapps

docker-compose up -d

cd $PROJECT_DIR
