#!/bin/bash
## file: angular_compile.sh
## This script compile angular application.


angular_compile () {
  echo "============================================================="
  echo "Installing Application's denpendencies ( npm install ) ..."
  echo "============================================================="
  npm install
  echo " "
  echo " "


  echo "============================================================="
  echo "Building Angular Application ..."
  echo "============================================================="
  if [ ${NG_ENV,,} = "prod" ]; then
    echo "executing ng build --${NG_ENV,,}"
    ng build --prod
  else
    echo "executing ng build --${NG_ENV,,}"
    ng build --dev
  fi
  echo " "
  echo " "

  echo "============================================================="
  echo "Copying dist directory content to ( /usr/share/nginx/html )  "
  echo "============================================================="
  cp -R dist/* /usr/share/nginx/html
  echo " "
  echo " "


  echo "============================================================="
  echo "Listing Application files  in ( /usr/share/nginx/html )      "
  echo "============================================================="
  ls -ls /usr/share/nginx/html
  echo " "
  echo " "
}