# Projeto AWS + Linux - PB Compass.UOL
Projeto de automação de criação de instâncias AWS EC2, monitoramento de serviços e programação de execução de rotinas via CRON.


### Requisitos da tarefa

* Criar chave pública
* Criar instância com S.O. Amazon Linux 2, hardware t3.small e 16GB SSD(gp3)
* Gerar Elastic IP e anexar à instância
* Liberar portas de comunicação com acesso público: 22/TCP, 111/TCP, 111/UDP, 2049/TCP, 2049/UDP, 80/TCP, 443/TCP
* Criar e configurar NFS com AWS EFS
* Instalar e disponibilizar servidor Apache
* Criar script para monitoramento do servidor Apache que seja executado automaticamente a cada 5 minutos
* Salvar resultado do monitoramento em dois logs de situação **ONLINE** e **OFFLINE**
* Os logs devem ser salvos no EFS
* Realizar versionamento dos scripts usando ```git```
* Fazer documentação do processo
</br>

## Criação da instância

### Processo de criação da instância
> A criação da instância não será feita através do console/GUI AWS, a criação será efetuada via script shell através da AWS CLI

Nos arquivos há um script chamado `settingUp_ec2instance.sh` que instrui à AWS as configurações necessárias para a criação da instância.

> Para execução do script é necessário já haver configurado a AWS CLI com region, output e as credenciais access_key_id e secret_access_key, bem como o arquivo do script deverá ter as devidas permissões de execução.

> O script não contempla a criação de VPC e Subnets, onde os mesmos já devem estar criados.

O script cria uma `key-pair` e consulta o ID da `VPC` e da `Subnet`
Então é criado o `Security Group` com a liberação das portas na sequência.

Posteriormente é definido os argumentos da criação da instância seguido da criação da instância passando como argumento do `--user-data` o arquivo `user_data_apache_server_script.sh` que contém o script para instalação e disponibilidado de servidor Apache.

Para evitar inconsistências devido o tempo de criação e disponibilização da instância, é feito um breve monitoramento a fim de continuar o script apenas após a completa disponibilização da instância.

Em seguida é alocado um `Elastic IP` e associado à instância recém criada.


## Criação de um NFS com a AWS EFS
A criação do EFS não é contemplada no script, porém basta realizar a criação de um volume EFS, e informar o DNS deste EFS à variável `DNS_efs` no script `NFS_EFS_configure.sh`
Este script deve ser executado na instância, acessada via SSH usando a chave `key-pair` criada no script inicial.


## Monitoramento de servidor Apache
Uma vez o EFS disponível, o script `apache_server_monitoring` monitorará o status do servidor, se o mesmo está **ONLINE** ou **OFFLINE**, o script salvará um log de monitoramento no diretório `/home/ec2-user/efs` onde o diretório `efs` é a montagem do volume EFS.

## Agendamento da execução do script
O script `apache_server_monitoring` faz o monitoramento do servidor Apache, porém há uma única execução deste monitoramento, para automatizarmos e mantermos constância na execução deste script usaremos o sistema `CRON`. No arquivo `crontab` aberto junto do argumento `-e` agendamos o script para ser executado a cada 5 minutos.

```*/5 * * * * /home/ec2-user/scripts/apache_server_monitoring.sh```
