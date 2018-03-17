#!/bin/bash
## file: maven_compile.sh
## This script verifies if compilation is using a specific repository and
## attach settings.xml if it is necessary.
 

maven_compile () {
echo "======================================================================="
echo "Running (mvn clean install) ...                                        "
echo "======================================================================="

if [ ! -z $REPO_URL ]; then
    echo " "
    echo " "
    echo "Using repository = $REPO_URL"
    echo " "
    echo " "
    ./mvnw clean install -s /compile/maven/settings.xml
else    
    ./mvnw clean install
    
fi

ARTIFACT_ID=`grep 'artifactId' /compile/myapp/src/target/maven-archiver/pom.properties|cut -d'=' -f2`  
ARTIFACT_VERSION=`grep 'version' /compile/myapp/src/target/maven-archiver/pom.properties|cut -d'=' -f2`
JAR_FILE=$ARTIFACT_ID'-'$ARTIFACT_VERSION'.jar'
echo '/deployment/'$JAR_FILE > /deployment/application_name.txt
echo " "
echo " "



echo "======================================================================="
echo "Copy deployment $JAR_FILE to /deployment ...                           "
echo "======================================================================="

cp /compile/myapp/src/target/$JAR_FILE /deployment

echo " "
echo " "



echo "======================================================================="
echo "Remove Maven disposable resources ...                                  "
echo "======================================================================="

rm -rf /home/appl/.m2 

echo " "
echo " "

}
