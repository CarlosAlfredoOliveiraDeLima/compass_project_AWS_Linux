#########################################################
#   Script para instalação de servidor Apache
#
#   O script será usado como argumento do --user-data
#   na criação da instância via CLI
#
#   Projeto estágio em DevSecOps - AWS / Compass.UOL
#
#   Carlos Alfredo Oliveira de Lima
#   28/03/2023
#########################################################

#!/bin/bash
yum update -y
yum install httpd -y
echo "Olá mundão véi!" > /var/www/html/index.html
systemctl enable httpd && systemctl start httpd