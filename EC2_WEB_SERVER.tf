# resource "aws_iam_instance_profile" "ssm_policy" {
#   name  = "ssm_policy"
#   role = aws_iam_role.ssm_policy.name
# }

resource "aws_instance" "WEB_SERVER" {
  ami = data.aws_ami.amazon-linux-2.id
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  key_name                    = var.key_pair
  vpc_security_group_ids      = [aws_security_group.WEB_SERVER.id]
  subnet_id = aws_subnet.vpc_a_public[0].id
  # iam_instance_profile = aws_iam_instance_profile.ssm_policy.name
  user_data = data.template_file.web_server.rendered
  private_ip = "10.0.0.10"
  credit_specification {
    cpu_credits = "standard"
  }
  root_block_device {
    volume_type = "gp3"
    volume_size = "8"
    iops = "3000"
    throughput = "125" 
  }
  tags = {
    Name = format(
      "%s-%s-WEB_SERVER",
      var.company,
      var.environment
     ),
     DEPLOY = "MZ-TRAINING-WEB_SERVER-DEPLOY-SPRING"
   }
  volume_tags = {
    Name = format(
      "%s-%s-WEB_SERVER",
      var.company,
      var.environment
     )
  }
}
resource "aws_eip" "eip_for_source" {
  instance = aws_instance.WEB_SERVER.id
  vpc      = true
  tags = {
    Name = "WEB_SERVER-EIP"
   }
}

resource "aws_security_group" "WEB_SERVER" {
  ingress {
    description = "From LB for HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.lb_sg.id]
  }  
  ingress {
    description = "From LB for Tomcat"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    security_groups = [aws_security_group.lb_sg.id]
  }  
  ingress {
    description = "From My Client IP Addr"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [local.my_ip_addrs]
  }
  ingress {
    description = "From My Client IP Addr for HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [local.my_ip_addrs]
  }
  ingress {
    description = "ALL ICMP"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = aws_vpc.vpc_a.id
  name = format(
      "%s-%s-WEB_SERVER",
      var.company,
      var.environment
     )
  description = format(
      "%s-%s-WEB_SERVER",
      var.company,
      var.environment
     )
  tags = {
    Name = format(
      "%s-%s-WEB_SERVER",
      var.company,
      var.environment
     )
  }
}


