#!/bin/sh

#commit
git commit -a -m "before the upload"

# pull
git pull origin master && git mergetool


grails update-static

git commit -a -m "new statics"

#tag with date
dateTag=`date "+%Y-%m-%d_%H.%M.%S"`
git tag upload.$dateTag

rm -rf target && grails prod clean-war

#split
rm -rf upload
mkdir upload
split -b 10m target/*.war upload/produ-war.war
