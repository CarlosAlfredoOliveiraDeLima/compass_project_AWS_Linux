#########################################################
#   Script para alocação de sistema de arquivo EFS
#
#   Projeto estágio em DevSecOps - AWS / Compass.UOL
#
#   Carlos Alfredo Oliveira de Lima
#   28/03/2023
#########################################################

cd ~/

yum update
yum upgrade
yum install nfs-utils

mkdir efs

DNS_efs=$"fs-0a09d6c56b4576d25.efs.us-east-1.amazonaws.com"

sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $DNS_efs:/ efs

