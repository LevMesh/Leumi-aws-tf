data "aws_vpc" "default" {
  id = var.vpc_id
  # filter {
    
  # }
}

data "aws_subnet" "public-sub" {
  id = var.public_subnet
}

data "aws_subnet" "first-private-sub" {
  id = var.first_private_subnet
}

data "aws_subnet" "second-private-sub" {
  id = var.second_private_subnet
}


resource "aws_security_group" "my-sg" {
  name        = "my-sg"
  description = "Security group for production python server"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description      = "Allow HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "TCP"
    cidr_blocks      = ["172.16.12.0/22"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


resource "aws_security_group" "alb-sg" {
  name        = "alb-sg"
  description = "Security group for alb"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description      = "Allow HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}