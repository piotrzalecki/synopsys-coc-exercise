provider "aws" {
   region     = "eu-west-1"
   profile    = "default"
}


  resource "aws_instance" "nginx-container" {
    ami           = "ami-06358f49b5839867c"
    instance_type = "t2.micro"
    key_name      = "cloud-operations"
    subnet_id = "${aws_subnet.public-subnet.id}"
    vpc_security_group_ids = ["${aws_security_group.sgweb.id}"]
    associate_public_ip_address = true
    tags = {
      Name = "nginx-container"
    }
  }

 resource "aws_db_instance" "default" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7.22"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot = true
  vpc_security_group_ids = ["${aws_security_group.sgdb.id}"]
  db_subnet_group_name   = "${aws_db_subnet_group.subnet_group.id}"
  availability_zone = "eu-west-1b"
}




  #   provisioner "remote-exec" {
  #   script =  "script.sh"   

  #   connection {        
  #   type     = "ssh"
  #   host = self.public_ip
  #   user     = "ubuntu"
  #   private_key = file("ec2Terraform082019.pem")
  # }
  # }


 
