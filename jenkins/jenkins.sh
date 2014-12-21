#! /bin/bash
#
# jenkins   Start/Stop the Jenkins Continuous Integration server.

# The following two lines are used by the chkconfig command. Change as is
#  appropriate for your application.  They should remain commented.
# chkconfig: 2345 99 01
# description: Test Wrapper Sample Application

if [ `id -u` -ne 0 ]; then
    echo "You need root privileges to run this script"
    exit 1
fi

[ -f /etc/profile.d/JAVA_HOME.sh ] && . /etc/profile.d/JAVA_HOME.sh
JENKINS_USER=jenkins

shutdown=/opt/jenkins/stop-jenkins.sh

start(){
 echo -n "Starting Jenkins service..."
 su - $JENKINS_USER -c /opt/jenkins/jenkins-start.sh
 RETVAL=$?
 echo "started"
}

stop(){
 echo "Stopping Jenkins service..."
 $JAVA_HOME/bin/java -jar /opt/jenkins/jenkins-cli.jar -s http://127.0.0.1/jenkins/ safe-shutdown
 /bin/sleep 5
# $JAVA_HOME/bin/java -jar /opt/jenkins/jenkins-cli.jar -s http://127.0.0.1/jenkins/ shutdown
 RETVAL=$?
 echo "stopped"
}

status(){
 numproc=`ps -ef | grep [j]enkins.war | wc -l`
 if [ $numproc -gt 0 ]; then
  echo "Jenkins is running..."
  else
  echo "Jenkins is stopped..."
 fi
}

restart(){
  stop
  sleep 5
  start
}


# See how we were called.
case "$1" in
start)
 start
 ;;
stop)
 stop
 ;;
status)
 status
 ;;
restart)
 restart
 ;;
*)
 echo $"Usage: $0 {start|stop|status|restart}"
 exit 1
esac

exit 0
