#########################################################
#   Script para criação de script de monitoramento de
#   servidor Apache
#
#   O script irá monitorar o servidor e gerar arquivos
#   tipo log do status do servidor em /home/ec2-user/efs
#
#   O diretório efs é um network file system do AWS EFS 

#   Projeto estágio em DevSecOps - AWS / Compass.UOL
#
#   Carlos Alfredo Oliveira de Lima
#   28/03/2023
#########################################################


status=$(systemctl is-active httpd.service)
data_hora=$(date +"%d-%m-%Y %H:%M:%S")
nome_service=$"Apache - httpd.service"
if [ $status == "active" ]; then
    message=$"O servidor está ONLINE"
    echo -e "Serviço $$data_hora - $nome_service. $message" >> /home/ec2-user/efs/log_online
else
    message=$"O servidor está OFFLINE"
    echo -e "$data_hora - $nome_service. $message" >> /home/ec2-user/efs/log_offline
fi
echo -e "$data_hora - $nome_service. $message" >> /home/ec2-user/efs/log_general

echo $message

