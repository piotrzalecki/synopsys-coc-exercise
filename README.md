<h2>Instructions to run code.</h2>

To run code you need 
-	install Ansible and Terraform;
-	install boto3 and botocore python packages;
-	set AWS credentials in local system for user with programmatic access and polices: AmazonRDSFullAccess, AmazonEC2FullAccess and AmazonVPCFullAccess;
-	create key pair of name “cloud-operations” in AWS console and copy provided by AWS key to ./Key directory. Replace existing there empty file,
-	in a main directory run command “. ./start_script.sh”,
-	enjoy full process automation 

<h2>Solution description.</h2>
I used Terraform to create AWS infrastructure for web service. It allows scale it in quick and efficient way. Code runs two EC2 instances, which at the beginning are on the same public subnet. One of them is a data base server, second web server. Except EC2’s Terraform will create one vpc with public and private subnet, route table and access control lists.  While creating web server script to install docker is run on the server.

I used Ansible to setup environment on EC2’s. Web server pulls created earlier by me docker image with basic php based website (for reference purpose you can find it in ./Docker) and runs it. On database server A. install MySql and then upload data base backup from ./Database, to set database configuration file is copied to the right place on database EC2.
Choices I made to accomplish task:
-	web server php file use environment variable to establish connection with database and display host name. Those variable are set up by Ansible while starting container and pull from local environment. Database address is pulled from file in .json format, which is created by Terraform when it creates db server (it contains db server ip).
-	db server at first is in public subnet, to allow setting it up by Ansible, later (in last script step) it is “moved” to private subnet to close connection from the “world”.
-	I decided to run database on EC2 rather than use RDS or other AWS managed solution, because I consider it as more transferable and loading database dump was easier. Later on servers can be managed by Ansible, so managing it by AWS is not necessary.
-	I decided to create docker image for web service as easy way to manga it’s different version or change it later.

<h2>Resources</h2>
- AWS
- Linux 18.04
- Terraform
- Ansible
- Docker

<h2>Exercise Feedback</h2>
It takes me about 25 hours to finish exercise. It was first time when I worked with both Ansible and Terraform. It was very interesting, challenging and let me gain a lot of valuable knowledge. It was journey from failure to failure but gave me a lot of satisfaction. 


