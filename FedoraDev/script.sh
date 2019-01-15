#!/bin/bash
#
# Script to install software for development VM for Fedora
#

# Run updates
whoami
dnf update -y
dnf upgrade -y

# Install Fedora Workstation GUI
dnf -y group install "Fedora Workstation"
echo "exec /usr/bin/gnome-session" >> ~/.xinitrc

# WGET
dnf install wget -y

# cURL
dnf install curl -y

# unzip
dnf install unzip -y

# p7zip
dnf install p7zip-full -y

# git
dnf install git-core -y

# java8
dnf install java-1.8.0-openjdk.x86_64 -y

# android studio
wget https://dl.google.com/dl/android/studio/ide-zips/3.2.1.0/android-studio-ide-181.5056338-linux.zip
unzip android-studio-ide-181.5056338-linux.zip -d /opt
bash /opt/android-studio/bin/studio.sh

# arduino
dnf install arduino arduino-core -y

# anaconda
wget https://repo.continuum.io/archive/Anaconda3-2018.12-Linux-x86_64.sh
bash Anaconda3-2018.12-Linux-x86_64.sh

# intellij
wget https://download.jetbrains.com/idea/ideaIC-2018.3.1.tar.gz
tar xf ideaIC-2018.3.1.tar.gz -C /opt/
bash /opt/idea-IC-183.4588.61/bin/idea.sh

# nodejs
dnf install nodejs -y
dnf install npm -y

# yarn
curl -sL https://dl.yarnpkg.com/rpm/yarn.repo -o /etc/yum.repos.d/yarn.repo
dnf install yarn

# export PATH
echo 'export PATH=$PATH:/opt/android-studio/bin'  >> ~/.bash_profile

# Setup GUI
systemctl set-default graphical.target
systemctl enable gdm.service
systemctl restart gdm.service
