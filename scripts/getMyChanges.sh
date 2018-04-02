# echo '# build.properties from force.json' > ./scripts/build.properties
# echo sf.username = $(cat force.json | jq -r .username) >> ./scripts/build.properties
# echo sf.password = $(cat force.json | jq -r .password) >> ./scripts/build.properties
# echo sf.serverurl = $(cat force.json | jq -r .url) >> ./scripts/build.properties
cd scripts
echo 'identify metadata available'
ant describeMetadata > output.log
thisyear=$(date +%Y)
echo '<project name="salesforceant" default="listMetadata" basedir="." xmlns:sf="antlib:com.salesforce"><property file="../build.properties"/><property environment="env"/><target name="listMetadata"><mkdir dir="listMetadata" />' > build_temp.xml
grep 'XMLName:' describe.log | sed 's/XMLName: /<sf:listMetadata username="${sf.username}" password="${sf.password}" serverurl="${sf.serverurl}" metadataType="/g' | sed 's/$/" trace="true" resultFilePath="listMetadata\/lists.log"\/>/g' >> build_temp.xml
echo '</target></project>' >> build_temp.xml
echo 'started identifying changes'
ant listMetadata -f build_temp.xml > output.log
echo 'downloaded changes , filtering out what has changed recently'
rm -Rf listMetadata
rm build_temp.xml
echo '<root>' > modifiedbyyou.xml
userid=$(head -100 output.log | grep -i "<userId>" | head -1 | sed 's/.*<userId>//' | sed 's/<\/userId\>//')
echo 'user id is : '$userid
grep -B 7 -A 5 'lastModifiedById>'$userid output.log |grep -B 10 -A 4 'manageableState>unmanaged' | grep -B 9 -A 3 'lastModifiedDate>'$thisyear | sed 's/\[sf:listMetadata\]//g' | sed 's/--//g' >> modifiedbyyou.xml
grep -B 1 -A 11 'createdById>'$userid output.log |grep -B 10 -A 4 'manageableState>unmanaged' | grep -B 3 -A 9 'createdDate>'$thisyear | sed 's/\[sf:listMetadata\]//g' | sed 's/--//g' >> modifiedbyyou.xml
echo '</root>' >> modifiedbyyou.xml
echo 'the package xml for the extraction is'
echo '<?xml version="1.0" encoding="UTF-8"?><Package xmlns="http://soap.sforce.com/2006/04/metadata">' > temp.xml
grep 'type\|fullName' modifiedbyyou.xml | sed 's/<fullName>/<types><members>/g' | sed 's/<\/fullName>/<\/members>/g' | sed 's/<type>/<name>/g'| sed 's/<\/type>/<\/name><\/types>/g' >> temp.xml
echo '<version>41.0</version></Package>' >> temp.xml
echo 'prepared package xml'
# rm modifiedbyyou.xml
cat temp.xml | xmllint --format - > package.xml
rm temp.xml describe.log modifiedbyyou.xml output.log
ant retrieve
rm package.xml
echo 'done'
echo 'please check the src folder for the components you might have worked on , as a starter.'