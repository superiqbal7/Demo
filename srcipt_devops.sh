#!/bin/bash
echo 'hello scripting'
pwd
#cd ..
#cd var/www/
#cleaning previous data
#rm -rf *
#downloading artifact
echo 'download data'
#curl --create-dirs -O --output ../var/www/ http://147.182.235.195:8081/repository/maven-nexus-repo/var/jenkins_home/workspace/devopsmakeeasy/artifact/artifact.tar.gz   #old one
curl --create-dirs -O -u admin:admin -L -X GET "http://147.182.235.195:8081/repository/maven-nexus-repo/var/jenkins_home/workspace/devopsmakeeasy/artifact/artifact.tar.gz" --output artifact.tar.gz && pwd
ls -la
#extracting
echo 'extrat data'
tar -xvzf artifact.tar.gz

#coping and replacing
echo 'coping data'
cd /var/www/var/jenkins_home/workspace/devopsmakeeasy/artifact/
cp -r /var/www/var/jenkins_home/workspace/devopsmakeeasy/artifact/.  /var/www/devopsmakeeasy.com


#cleaning
echo 'cleaning data'
cd /var/www/devopsmakeeasy.com/
echo 'current location'
pwd
cd /var/www/
rm -rf var
#rm -rf airtifact
rm  artifact.tar.gz
rm  srcipt_devops.sh
pwd


