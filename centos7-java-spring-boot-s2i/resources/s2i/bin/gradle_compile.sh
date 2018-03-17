#!/bin/bash
## file: gradle_compile.sh
## This script verifies if compilation is using a specific repository


gradle_compile () {
echo "======================================================================="
echo "Running (gradle clean build) ...                                       "
echo "======================================================================="

if [ ! -z $REPO_URL ]; then
    echo " "
    echo " "
    echo "Using repository = $REPO_URL"
    echo " "
    echo " "
fi

./gradlew clean build
BASE_NAME=`grep 'baseName' /compile/myapp/src/build.gradle|cut -d'=' -f2`  
VERSION=`grep 'version' /compile/myapp/src/build.gradle|cut -d'=' -f2`
JAR_FILE=${BASE_NAME//[\'[:space:]]/}'-'${VERSION//[\'[:space:]]/}'.jar'
echo '/deployment/'$JAR_FILE > /deployment/application_name.txt
echo " "
echo " "



echo "======================================================================="
echo "Copy deployment $JAR_FILE to /deployment ...                          "
echo "======================================================================="

cp /compile/myapp/src/build/libs/$JAR_FILE /deployment

echo " "
echo " "



echo "======================================================================="
echo "Remove Gradle disposable resources ...                                 "
echo "======================================================================="
rm -rf /home/appl/.gradle
echo " "
echo " "

}
