
provider "aws" {
  region = "ap-south-1"   # Mumbai region
}

# ---------------- VPC ----------------
resource "aws_vpc" "myvpc" {
  cidr_block = "171.0.0.0/16"
  tags = {
    Name = "Devops_VPC"
  }
}

# ---------------- Subnet ----------------
resource "aws_subnet" "mysubnet1" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "171.0.0.0/17"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Devops_SUB1"
  }
}
resource "aws_subnet" "mysubnet2" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "171.0.128.0/18"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Devops_SUB2"
  }
}
resource "aws_subnet" "mysubnet3" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "171.0.192.0/27"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Devops_SUB3"
  }
}

# ---------------- Internet Gateway ----------------
resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "Devops_IGW"
  }
}

# ---------------- Route Table ----------------
resource "aws_route_table" "myrt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
  }

  tags = {
    Name = "Devops_RT"
  }
}

# Route Table Association
resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.mysubnet1.id
  route_table_id = aws_route_table.myrt.id
}
resource "aws_route_table_association" "rta2" {
  subnet_id      = aws_subnet.mysubnet2.id
  route_table_id = aws_route_table.myrt.id
}
resource "aws_route_table_association" "rta3" {
  subnet_id      = aws_subnet.mysubnet3.id
  route_table_id = aws_route_table.myrt.id
}

# ---------------- Security Group ----------------
resource "aws_security_group" "mysg" {
  vpc_id = aws_vpc.myvpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Devops_SG"
  }
}

resource "aws_key_pair" "my_key"{
public_key = file("ec2_key.pub")
}

# ---------------- EC2 Instance ----------------
resource "aws_instance" "myec2" {
  ami           = "ami-0f5ee92e2d63afc18"   # Ubuntu 22.04 (Mumbai region)
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.mysubnet1.id
  security_groups = [aws_security_group.mysg.id]
  key_name      = aws_key_pair.my_key.key_name   # 🔴 Replace with your key pair name

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install nginx -y
              sudo apt install git -y
              sudo systemctl start nginx
              sudo systemctl enable nginx

              cd /var/www/html
              sudo rm -rf *
              sudo git clone https://github.com/prerana1237/index1.git .
              EOF
  tags = {
    Name = "Devops_instance"
  }
}

# ---------------- Output ----------------
output "public_ip" {
  value = aws_instance.myec2.public_ip

}
