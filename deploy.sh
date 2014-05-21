echo -e "\033[0;32mDeploying updates to Github...\033[0m"

# deps
npm install

# compile
gulp build
hugo

# deploy
mv ./public/* .
git add -A
git commit -m 'Updating blog!'
git push origin master
