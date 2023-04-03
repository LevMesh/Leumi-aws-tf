
resource "aws_lb" "my-alb" {

  name               = "aws-load-balancer"
  load_balancer_type = "application"
  ip_address_type    = "ipv4"
  internal           = false
  subnets            = [data.aws_subnet.public-sub.id, data.aws_subnet.first-private-sub.id]
  security_groups    = [aws_security_group.alb-sg.id]

}

resource "aws_lb_target_group" "my-tg" {

  name        = "my-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = data.aws_vpc.default.id

  health_check {
    healthy_threshold   = 5
    unhealthy_threshold = 3
    interval            = 5
    timeout             = 3
    path                = "/"
    protocol            = "HTTP"
  }
}


resource "aws_lb_target_group_attachment" "tg-attach-1" {

  # count = length(aws_instance.instance)
  target_group_arn = aws_lb_target_group.my-tg.arn
  target_id        = aws_instance.ec2.id

}

resource "aws_lb_listener" "alb-listener" {

  load_balancer_arn = aws_lb.my-alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.acm_certificate.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my-tg.arn
  }


}

output "alb-dns-name" {
  value = aws_lb.my-alb.dns_name
}