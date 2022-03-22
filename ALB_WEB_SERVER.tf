resource "aws_lb" "WEB_LB" {
  name               = format(
      "%s-%s-WEB-LB",
      var.company,
      var.environment
     )
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = aws_subnet.vpc_a_public.*.id
  enable_deletion_protection = false

}

resource "aws_lb_target_group" "WEB_SERVER_TG" {
  name     = format(
      "%s-%s-WEB-SERVER-80-TG",
      var.company,
      var.environment
     )
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc_a.id
}
resource "aws_lb_target_group_attachment" "WEB_SERVER_TG" {
  target_group_arn = aws_lb_target_group.WEB_SERVER_TG.arn
  target_id        = aws_instance.WEB_SERVER.id
  port             = 80
}

resource "aws_lb_target_group" "WEB_SERVER_8080_TG" {
  name     = format(
      "%s-%s-WEB-SERVER-8080-TG",
      var.company,
      var.environment
     )
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc_a.id
}
resource "aws_lb_target_group_attachment" "WEB_SERVER_8080_TG" {
  target_group_arn = aws_lb_target_group.WEB_SERVER_8080_TG.arn
  target_id        = aws_instance.WEB_SERVER.id
  port             = 8080
}

# resource "aws_lb_target_group" "WEB_ASG_TG" {
#   name     = format(
#       "%s-%s-WEB-ASG-TG",
#       var.company,
#       var.environment
#      )
#   port     = 90
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.vpc_a.id
# }

# resource "aws_lb_target_group" "WEB_ECS_TG" {
#   name     = format(
#       "%s-%s-WEB-ECS-TG",
#       var.company,
#       var.environment
#      )
#   port     = 100
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.vpc_a.id
# }

resource "aws_lb_listener" "WEB_SERVER" {
  load_balancer_arn = aws_lb.WEB_LB.arn
  port              = "80"
  protocol          = "HTTP"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.WEB_SERVER_TG.arn
  }
}
resource "aws_lb_listener" "WEB_SERVER_8080" {
  load_balancer_arn = aws_lb.WEB_LB.arn
  port              = "8080"
  protocol          = "HTTP"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.WEB_SERVER_8080_TG.arn
  }
}

resource "aws_security_group" "lb_sg" {
  ingress {
    description = "From My Client IP Addr for EC2"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [local.my_ip_addrs]
  }
  ingress {
    description = "From My Client IP Addr for EC2"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [local.my_ip_addrs]
  }
  ingress {
    description = "From My Client IP Addr for ASG"
    from_port   = 90
    to_port     = 90
    protocol    = "tcp"
    cidr_blocks = [local.my_ip_addrs]
  }
  ingress {
    description = "From My Client IP Addr for ECS"
    from_port   = 100
    to_port     = 100
    protocol    = "tcp"
    cidr_blocks = [local.my_ip_addrs]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = aws_vpc.vpc_a.id
  name = format(
      "%s-%s-WEB_LB",
      var.company,
      var.environment
     )
  description = format(
      "%s-%s-WEB_LB",
      var.company,
      var.environment
     )
  tags = {
    Name = format(
      "%s-%s-WEB_LB",
      var.company,
      var.environment
     )
  }
}