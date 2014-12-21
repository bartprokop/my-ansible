#!/bin/bash

export JENKINS_HOME=/opt/jenkins/home
JENKINS_WAR=/opt/jenkins/jenkins.war
JENKINS_LOG=$JENKINS_HOME/jenkins-start.log
JAVA=$JAVA_HOME/bin/java

nohup nice $JAVA -jar $JENKINS_WAR --httpListenAddress=127.0.0.1 --prefix=/jenkins > $JENKINS_LOG 2>&1 &
