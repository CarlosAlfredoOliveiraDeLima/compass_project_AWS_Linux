#########################################################
#   Script para instalação e disponibilização de servidor
#   Apache
#
#   Projeto estágio em DevSecOps - AWS / Compass.UOL
#
#   Carlos Alfredo Oliveira de Lima
#   28/03/2023
#########################################################


#Necessário instalar como sudo devido impedimentos do usuário ec2-user na AWS
sudo yum update -y
sudo yum install -y httpd.x86_64
sudo systemctl start httpd.service
sudo systemctl enable httpd.service


#Este comando pode não funcionar, caso não funcione será necessário ir até o diretório
#/var/www/html e criar com vi/vim/nano um arquivo simples de html como este:
# <!DOCTYPE html>
# <html>
#   <body>
#     <h1>Olá Compass!!</h1>
#   </body>
# </html>
sudo echo “Hello World from $(hostname -f)” > /var/www/html/index.html