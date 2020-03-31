#!/bin/bash -x

WEBAPP=cas.war
CONTAINER=cas6
DOCKER_DIR=/opt/docker/CAS/$CONTAINER
PROJECT_DIR=$PWD
PROJECT_TARGET=$PROJECT_DIR/target



if [ -d $PROJECT_TARGET ] && [ -f $PROJECT_TARGET/$WEBAPP ] && [ -f $PROJECT_TARGET/etc/cas/config/cas.properties ];
then

        cd $DOCKER_DIR
	if [ $(docker ps -q -f name=$CONTAINER | wc -c) -gt 0 ]; then

	    #if [ $(docker ps -aq -f status=exited -f name=$CONTAINER) ]; then
		# cleanup
	    #	docker rm $CONTAINER
	    #fi
	    docker-compose down
	fi

	# Log files delete
	if [ `ls -a "tomcat/cas/logs" | wc -l` -gt 2 ];then
	   rm $DOCKER_DIR/tomcat/cas/logs/*
	fi

	# Delete config in etc/cas
	if [ -d $DOCKER_DIR/tomcat/cas/etc/cas/ ];
	then
	   rm -fr $DOCKER_DIR/tomcat/cas/etc/cas/*
	fi


	# Copy new config from project
	cp -r $PROJECT_TARGET/etc/cas $DOCKER_DIR/tomcat/cas/etc

	# Delete old webapp
	if [ -d $DOCKER_DIR/tomcat/cas/webapps/cas ];
	then
	   rm -fr $DOCKER_DIR/tomcat/cas/webapps/$WEBAPP*
	fi



	#if [ -f $DOCKER_DIR/tomcat/cas/webapps/$WEBAPP ];
	#then
	#   rm $DOCKER_DIR/tomcat/cas/webapps/$WEBAPP
	#fi

	cp $PROJECT_TARGET/$WEBAPP $DOCKER_DIR/tomcat/cas/webapps

	docker-compose up -d

	cd $PROJECT_DIR
else
	echo "No Project target"
fi
