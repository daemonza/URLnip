#!/usr/bin/env bash
# Installs Twitter Bootstrap
# Coded by Werner Gillmer <werner.gillmer@gmail.com>

curl -l http://twitter.github.com/bootstrap/assets/bootstrap.zip >> ./bootstrap.zip
unzip ./bootstrap.zip
rm ./bootstrap.zip

mkdir ./public
mv bootstrap ./public
