#!/usr/bin/env bash
# Installs Twitter Bootstrap and grabs JQuery
# Coded by Werner Gillmer <werner.gillmer@gmail.com>

curl -l http://twitter.github.com/bootstrap/assets/bootstrap.zip >> ./bootstrap.zip
unzip ./bootstrap.zip
rm ./bootstrap.zip

if [ -d ./public ]; then
  rm -Rfv ./public
fi

mkdir ./public
mv bootstrap ./public
curl -l http://code.jquery.com/jquery-1.7.1.min.js >> ./public/bootstrap/js/jquery-1.7.1.min.js

echo "-== Done"
