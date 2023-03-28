# #Key-pair creation for Compass project
# ec2_key_pair_name="key_pair_projeto_compass"
# aws ec2 create-key-pair --key-name "$ec2_key_pair_name" --query 'KeyMaterial' --output text > ~/.ssh/key_testing.pem



# #querying vpc id
# vpc_vpc_id=$(aws ec2 describe-vpcs --filters --query "Vpcs[0].VpcId" --output text)
# sleep 3



# #Querying subnet id from a subnet in AZ us-east-1
# vpc_sn_id=$(aws ec2 describe-subnets --filters "Name=availability-zone,Values=us-east-1a" --query "Subnets[*].SubnetId" --output text)





# #Security group definition
# ec2_sg_name="sg_projeto_compass"
# ec2_sg_description="Security-group criado para o projeto de Linux e AWS da Compass.UOL"

# aws ec2 create-security-group --group-name "$ec2_sg_name" --description "$ec2_sg_description" --vpc-id vpc-06d802272a5329f40

# sleep 5

# ec2_sg_id=$(aws ec2 describe-security-groups --filters "Name=group-name,Values=$ec2_sg_name" --query "SecurityGroups[0].GroupId" --output text) 

# aws ec2 authorize-security-group-ingress --group-id "$ec2_sg_id" --protocol tcp --port 22 --cidr 0.0.0.0/0
# aws ec2 authorize-security-group-ingress --group-id "$ec2_sg_id" --protocol tcp --port 111 --cidr 0.0.0.0/0
# aws ec2 authorize-security-group-ingress --group-id "$ec2_sg_id" --protocol udp --port 111 --cidr 0.0.0.0/0
# aws ec2 authorize-security-group-ingress --group-id "$ec2_sg_id" --protocol tcp --port 2049 --cidr 0.0.0.0/0
# aws ec2 authorize-security-group-ingress --group-id "$ec2_sg_id" --protocol udp --port 2049 --cidr 0.0.0.0/0
# aws ec2 authorize-security-group-ingress --group-id "$ec2_sg_id" --protocol tcp --port 80 --cidr 0.0.0.0/0
# aws ec2 authorize-security-group-ingress --group-id "$ec2_sg_id" --protocol tcp --port 443 --cidr 0.0.0.0/0
# aws ec2 authorize-security-group-ingress --group-id "$ec2_sg_id" --ip-permissions '[{"IpProtocol": "icmp", "FromPort": 8, "ToPort": 0, "IpRanges": [{"CidrIp": "0.0.0.0/0"}]}]'
# aws ec2 authorize-security-group-ingress --group-id "$ec2_sg_id" --ip-permissions '[{"IpProtocol": "icmp", "FromPort": -1, "ToPort": -1, "IpRanges": [{"CidrIp": "0.0.0.0/0"}]}]'


# sleep 10



# #EC2 instance standards
ec2_ami_id="ami-04581fbf744a7d11f" #Amazon Linux 2 AMI(HVM) - Kernel 5.10
ec2_instance_quantity=1
ec2_instance_type="t3.small"
ec2_instance_tag_name="instancia_projeto_compass"
ec2_instance_tag_costcenter="C092000004"
ec2_instance_tag_project="PB UNIVEST URI"
ec2_region="us-east-1"
ebs_volume=16
ebs_type="gp3"

# device={\"DeviceName\":\"/dev/xvda\",\"Ebs\":{\"VolumeSize\":$ebs_volume,\"VolumeType\":\"$ebs_type\"}}

# aws ec2 run-instances \
# --image-id "$ec2_ami_id" \
# --count $ec2_instance_quantity \
# --instance-type "$ec2_instance_type" \
# --key-name "$ec2_key_pair_name" \
# --security-group-ids "$ec2_sg_id" \
# --subnet-id "$vpc_sn_id" \
# --region "$ec2_region" \
# --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$ec2_instance_tag_name}, {Key=CostCenter,Value=$ec2_instance_tag_costcenter}, {Key=Project,Value=$ec2_instance_tag_project}]" \
# "ResourceType=volume,Tags=[{Key=Name,Value=$ec2_instance_tag_name}, {Key=CostCenter,Value=$ec2_instance_tag_costcenter}, {Key=Project,Value=$ec2_instance_tag_project}]" \
# --block-device-mappings "[$device]"

id_instancia=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=$ec2_instance_tag_name" --query "Reservations[*].Instances[*].InstanceId" --output text)
publicDnsName=$(aws ec2 describe-instances --instance-ids $id_instancia --query "Reservations[*].Instances[*].PublicDnsName" --output text)


#Allocate a Elastic Ip and getting the Fixed PublicIp 
elastic_public_ip=$(aws ec2 allocate-address)
elastic_public_ip=$(echo $elastic_public_ip | jq -r '.PublicIp') #jq é um processador de json para bash/shell caso não possua no PC instale primeiramente

#Associate a Elastic IP

