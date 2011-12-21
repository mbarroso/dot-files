git filter-branch --index-filter 'git rm --cached --ignore-unmatch bin/tweet.sh' --prune-empty -- --all
git filter-branch --index-filter 'git rm --cached --ignore-unmatch bin/check-domain.sh' --prune-empty -- --all
git filter-branch --index-filter 'git rm --cached --ignore-unmatch bin/cdslkey.ppk' --prune-empty -- --all
echo bin/tweet.sh >> .gitignore
echo bin/check-domain.sh >> .gitignore
echo bin/cdslkey.ppk >> .gitignore
