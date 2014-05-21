echo "\033[0;32mDeploying updates to Github...\033[0m"

# remove old
rm -rf css img index.html index.xml posts scss tags sitemap.xml

# deps
npm install

# compile
gulp build
hugo

# deploy
mv ./public/* .
rm -rf node_modules public scss
git add -A
git commit -m 'Updating blog!'
git push origin master
