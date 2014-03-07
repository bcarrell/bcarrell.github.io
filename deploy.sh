npm install
roots compile
rm -rf assets posts views node_modules
rm app.coffee package.json
cp -r public/* .
rm -rf public
