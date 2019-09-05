52.215.43.234# !/bin/bash

#Setting color for echo command
YEL='\033[0;33m'
NC='\033[0m'


#Setting environement variables
echo -e "${YEL}--- Exporting enironment variables  --- ${NC}"
export DB_NAME=testdb
export DB_USERNAME=appuser
export DB_PASSWORD=somepassword
echo -e "${YEL}--- Environment variables has been exported ---${NC}"

echo -e "${YEL}--- Running terraform --- ${NC}"
cd Terraform/
terraform init
echo "yes" | terraform apply
cd ..
echo -e "${YEL}--- Terraform tasks done  --- ${NC}"

echo -e "${YEL}--- Watiting 3 minutes to let AWS finish creating EC2 instances  --- ${NC}"
sleep 3m

echo -e "${YEL}--- Running Ansible playbooks ---${NC}"
echo "yes" | ansible-playbook ./Ansible/database.yml --private-key ./Key/cloud-operations.pem -i ./Ansible/aws_ec2.yaml
ansible-playbook ./Ansible/database.yml --private-key ./Key/cloud-operations.pem -i ./Ansible/aws_ec2.yaml 
echo "yes" | ansible-playbook ./Ansible/docker-ubuntu.yml --private-key ./Key/cloud-operations.pem -i ./Ansible/aws_ec2.yaml --extra-vars "@./Ansible/dbaddress.json"
ansible-playbook ./Ansible/docker-ubuntu.yml --private-key ./Key/cloud-operations.pem -i ./Ansible/aws_ec2.yaml --extra-vars "@./Ansible/dbaddress.json"
echo -e "${YEL}--- Ansible tasks done  --- ${NC}"

echo -e "${YEL}--- Moving db server to private subnet  ---${NC}"
cd Terraform/
cp ./LockDB/main.tf .
terraform apply
echo -e "${YEL}--- DONE ---${NC}" 
