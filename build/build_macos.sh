#!/bin/bash

aob_package=${1}
aob_project=${2}
gtar -xzf ${aob_package}
ta_name="TA-thinkst-canary"

aob_version=$(grep 'version =' "./${ta_name}/default/app.conf" | awk '{print $3}' | sed 's/\./_/g')
sb_version=$(grep 'version =' "./${ta_name}/default/app.conf" | awk '{print $3}' | sed 's/\.//g')
ta_version=$(grep 'version =' "./${ta_name}/default/app.conf" | awk '{print $3}')

cp ${aob_project} "../aob_project/"

if [[ -f "../aob_project/${ta_name}_${aob_version}_export.tgz" ]]; then
  echo "Splunk Add-on Builder project export found"
else
  echo "Splunk Add-on Builder project export not found. Exiting."
  exit 1
fi

cp ../src/globalConfig.json ./${ta_name}/appserver/static/js/build/
gsed -i "s/x\.y\.z/${ta_version}/g" ./${ta_name}/appserver/static/js/build/globalConfig.json
cp ../src/inputs.conf ./${ta_name}/default/
cp ../src/macros.conf ./${ta_name}/default/
cp ../src/server.conf ./${ta_name}/default/

xattr -rc ./${ta_name}

gtar -czf "../${ta_name}_${sb_version}.tgz" ${ta_name}

sleep 2
rm -rf ./${ta_name}
