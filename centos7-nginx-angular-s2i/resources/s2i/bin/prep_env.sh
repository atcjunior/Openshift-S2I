#!/bin/bash
## file: prep_env.sh
## This script set and check arguments used during compilation process
 

prep_env () {
    echo "============================================================="
    echo "Checking Environment Variables ...                           "
    echo "============================================================="

    ## Defile source code dir
    SRC_DIR="/compile/myapp/src"

    ## Verify variable NG_ENV informed to choose config template and environment file
    echo ""
    if [ ! -z $NG_ENV ] && [ ${NG_ENV^^} == "DEV" ] || [ ${NG_ENV^^} == "PROD" ]; then
        echo " "
        echo " "
        echo "This code will be compiled for ${NG_ENV^^} environment"
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
