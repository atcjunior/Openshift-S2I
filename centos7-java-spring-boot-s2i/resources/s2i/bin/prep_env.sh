#!/bin/bash
## file: prep_env.sh
## This script set JAVA_HOME to openjdk installation and check build arguments
 

prep_env () {
echo "======================================================================="
echo "Set JAVA_HOME ...                                                      "
echo "======================================================================="
export JAVA_HOME=/usr/lib/jvm/java-1.8.0
echo " "
echo " "
echo "JAVA_HOME = $JAVA_HOME"
echo " "
echo " "

echo "======================================================================="
echo "Checking Build Arguments ...                                           "
echo "======================================================================="

## Verify build tool (MAVEN OR GRADLE)
echo " "
echo " "
if [ ! -z $BUILD_TOOL ] && [ ${BUILD_TOOL^^} == "MAVEN" ] || [ ${BUILD_TOOL^^} == "GRADLE" ]; then
    echo "${BUILD_TOOL^^} will be used to compile this code."
    echo " "
    echo " "
else
    ## Show script usage
    echo "Please check informed arguments!"
    echo " "
    /usr/local/s2i/usage 
    echo " "
    echo " "
    exit 1
fi    


}
