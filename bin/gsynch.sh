current_branch=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
rm -rf `find . -regex .+\.orig`
echo "Branch Actual: $current_branch"
echo "1/3 git pull origin $current_branch ..."
git pull origin $current_branch
echo "2/3 git push origin $current_branch ..."
git push origin $current_branch
git push --tags
echo "3/3 git pull --force ..."
git pull --force
echo "terminado!"
