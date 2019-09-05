provider "aws" {
  region  = "eu-west-1"
  profile = "default"
}


resource "aws_instance" "webserver" {
  count                       = 1
  ami                         = "ami-06358f49b5839867c"
  instance_type               = "t2.micro"
  key_name                    = "cloud-operations"
  user_data                   = "${file("./Scripts/script.sh")}"
  subnet_id                   = "${aws_subnet.public-subnet.id}"
  vpc_security_group_ids      = ["${aws_security_group.sgweb.id}"]
  associate_public_ip_address = true
  tags = {
    Name = "web-server"
  }
}

resource "aws_instance" "database" {
  ami                         = "ami-06358f49b5839867c"
  instance_type               = "t2.micro"
  key_name                    = "cloud-operations"
  subnet_id                   = "${aws_subnet.public-subnet.id}"
  vpc_security_group_ids      = ["${aws_security_group.sgweb.id}"]
  associate_public_ip_address = true
  tags = {
    Name = "db-server"
  }

}

resource "local_file" "dbaddress" {
  content = "{'dbaddress':'£{aws_instance.database.public_ip}'}"
  filename = "../Ansible/dbaddress.json"

}
