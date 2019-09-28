#!/bin/bash

myuser="habbis"
myemail="habbis@medmail.ch"
editor="vim"


git config --global user.name ${myuser}
sleep 1
git config --global user.email ${myemail}
sleep 1
git config --system core.editor ${editor} 
echo "alt ferdig med git"
