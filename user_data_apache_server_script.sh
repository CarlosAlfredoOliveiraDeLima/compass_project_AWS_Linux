#!/bin/bash
yum update -y
yum install httpd -y
echo "Olá mundão véi!" > /var/www/html/index.html
systemctl enable httpd && systemctl start httpd
