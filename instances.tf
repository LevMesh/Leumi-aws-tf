resource "aws_instance" "ec2" {

  ami                    = var.ami_type
  instance_type          = var.instance_type
  subnet_id              = data.aws_subnet.public-sub.id
  # vpc_security_group_ids = [aws_security_group.my-sg.id]
  user_data              = file("install.sh")
  iam_instance_profile   = aws_iam_instance_profile.ec2_s3_profile.id
  security_groups = [aws_security_group.my-sg.id]
  

  associate_public_ip_address = true

  metadata_options {
    http_tokens   = "required"
    http_endpoint = "enabled"
  }

  #depends_on = [
  #security_groups = 
  #]
}