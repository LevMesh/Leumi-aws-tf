variable "aws_region" {
  description = "Desired aws region"
  type        = string
  default     = "eu-west-1"
}

variable "ami_type" {
  description = "Type of image"
  type        = string
  default     = "ami-00aa9d3df94c6c354"
}


variable "instance_type" {
  description = "Type of instance"
  type        = string
  default     = "t2.micro"
}

variable "vpc_id" {
  description = "vpc"
  type        = string
  default     = "vpc-052ea6d35810b17c0"

}

variable "first_private_subnet" {
  description = "ID of the first private subnet in the default vpc"
  type        = string
  default     = "subnet-0c91a1f9641338171"
}

variable "second_private_subnet" {
  description = "ID of the second private subnet in the default vpc"
  type        = string
  default     = "subnet-0277c228c75a41884"
}

variable "public_subnet" {
  description = "ID of the public subnet in the default vpc"
  type        = string
  default     = "subnet-0d71e5158d7927d52"
}


variable "domain_name" {
  description = "Domain name"
  type        = string
  default     = "lev.leumi-nonprod.com"
}


#################################################
####################--Tags--#####################
#################################################


variable "additional_tags" {

  description = "Additional resource tags"
  type        = map(string)

  default = {
    "created_by"    = "Lev Meshorer"
    "creation_date" = "30.03.2023"
    "deployed_with" = "Terraform"
  }

}
