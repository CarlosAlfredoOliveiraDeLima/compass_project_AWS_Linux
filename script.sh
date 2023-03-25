vpc_vpc_id=$(aws ec2 describe-vpcs --filters --query "Vpcs[0].VpcId" --output text)
sleep 3

ec2_sg_name="sg_projeto_compass"
ec2_sg_description="Security-group criado para o projeto de Linux e AWS da Compass.UOL"

aws ec2 create-security-group --group-name "$ec2_sg_name" --description "$ec2_sg_description" --vpc-id vpc-06d802272a5329f40

sleep 5

ec2_sg_id=$(aws ec2 describe-security-groups --filters "Name=group-name,Values=$ec2_sg_name" --query "SecurityGroups[0].GroupId" --output text) 

#echo $ec2_sg_id

aws ec2 authorize-security-group-ingress --group-id "$ec2_sg_id" --protocol tcp --port 22 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id "$ec2_sg_id" --protocol tcp --port 111 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id "$ec2_sg_id" --protocol udp --port 111 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id "$ec2_sg_id" --protocol tcp --port 2049 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id "$ec2_sg_id" --protocol udp --port 2049 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id "$ec2_sg_id" --protocol tcp --port 80 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id "$ec2_sg_id" --protocol tcp --port 443 --cidr 0.0.0.0/0
