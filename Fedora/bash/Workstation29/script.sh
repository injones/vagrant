#!/bin/bash
#
# Script to install software for development VM for Fedora
#

# Run updates
whoami
dnf update -y
dnf upgrade -y

# resize partition /dev/sda3 to fill vdi and extend filesystem
echo -e "yes\n100%\n" | parted ---pretend-input-tty /dev/sda resizepart 3
xfs_growfs /

# make directory for downloads
mkdir /usr/downloads

# Install Fedora Workstation GUI
dnf -y group install "Fedora Workstation"
echo "exec /usr/bin/gnome-session" >> ~/.xinitrc

# WGET
dnf install wget -y

# cURL
dnf install curl -y

# unzip
dnf install unzip -y

# git
dnf install git-core -y

# java8
dnf install java-1.8.0-openjdk.x86_64 -y

# Expect
dnf install bzip2 -y
dnf install expect -y

# android studio
dnf install bzip2 -y
cd /usr/downloads
wget https://dl.google.com/dl/android/studio/ide-zips/3.2.1.0/android-studio-ide-181.5056338-linux.zip
unzip android-studio-ide-181.5056338-linux.zip -d /opt

# arduino
dnf install arduino arduino-core -y

# anaconda and visual studio code
cd /usr/downloads
wget https://repo.continuum.io/archive/Anaconda3-2018.12-Linux-x86_64.sh
cp /home/vagrant/anaconda.exp /usr/downloads/
expect anaconda.exp
#bash Anaconda3-2018.12-Linux-x86_64.sh -y

# intellij
cd /usr/downloads
wget https://download.jetbrains.com/idea/ideaIC-2018.3.1.tar.gz
tar xf ideaIC-2018.3.1.tar.gz -C /opt/

# nodejs
dnf install nodejs -y

# npm
dnf install npm -y

# yarn
npm install yarn -g

# gradle
mkdir /opt/gradle
cd /usr/downloads
wget https://services.gradle.org/distributions/gradle-5.1.1-bin.zip
unzip -d /opt/gradle gradle-5.1.1-bin.zip

# maven
mkdir /opt/maven
cd /usr/downloads
wget http://apache.mirrors.nublue.co.uk/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.zip
unzip -d /opt/maven apache-maven-3.6.0-bin.zip

# vb extension
code --install-extension ms-vscode.cpptools

# export PATH
echo 'export PATH=$PATH:/opt/android-studio/bin'  >> ~/.bash_profile
echo 'export PATH=$PATH:/opt/gradle/gradle-5.1.1/bin' >> ~/.bash_profile
echo 'export PATH=$PATH:/opt/maven/apache-maven-3.6.0/bin' >> ~/.bash_profile

# Setup GUI
systemctl set-default graphical.target
systemctl enable gdm.service
systemctl restart gdm.service
