#!/usr/bin/sh
current_branch=`groovy scripts/git/getBranch.groovy`
git pull origin $current_branch
# generate chanchelog
current_version=`groovy scripts/git/getVersion.groovy`
echo "with branch '$current_branch' version '$1' last version '$current_version' user $USER"
echo "generate chanchelog"
git log --no-merges --format=" * %h %ad %cn %s" $current_version.. > Changelog
sh scripts/git/doVersion.sh $1
git commit -a -m "new version"
git push origin $current_branch
grails generate_war $USER  -b $current_branch -notest

git pull --force
