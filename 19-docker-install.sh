#!/bin/bash

ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"


TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE="/tmp/$0-$TIMESTAMP.log"

echo "script stareted executing at $TIMESTAMP" &>> $LOGFILE

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 ... $R FAILED $N"
        exit 1
    else
        echo -e "$2 ... $G SUCCESS $N"
    fi
}

if [ $ID -ne 0 ]
then
    echo -e "$R ERROR:: Please run this script with root access $N"
    exit 1 # you can give other than 0
else
    echo "You are root user"
fi # fi means reverse of if, indicating condition end

yum install -y yum-utils

VALIDATE $? "Installed yum utils"

yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

VALIDATE $? "Added docker repo"

yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

VALIDATE $? "Installed docker components"

systemctl start docker

VALIDATE $? "Started docker"

systemctl enable docker

VALIDATE $? "Enabled docker"

usermod -aG docker centos

VALIDATE $? "added centos user to docker group"

curl -L https://github.com/docker/compose/releases/download/2.24.6/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

docker compose version

VALIDATE $? "Installed docker compose"

echo -e "$R Logout and login again $N"