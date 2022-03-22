# AWS Virtual Private Cloud
resource "aws_vpc" "vpc_a" {
  cidr_block = var.vpc-a_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  assign_generated_ipv6_cidr_block = var.assign_generated_ipv6_cidr_block
  instance_tenancy = var.instance_tenancy
  tags = {
      Name = format(
        "%s-%s-VPC",
        var.company,
        var.environment
      )
  }
}
resource "aws_internet_gateway" "igw_a" {
  vpc_id = aws_vpc.vpc_a.id
  tags = {
      Name = format(
        "%s-%s-IGW",
        var.company,
        var.environment
      )
  }
}

resource "aws_route_table" "vpc_a_public" {
  depends_on = [aws_internet_gateway.igw_a] 
  vpc_id = aws_vpc.vpc_a.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_a.id
  }
  tags = {
    Name = format(
        "%s-%s-vpc-rt-pub",
        var.company,
        var.environment
    )
  }
}

resource "aws_subnet" "vpc_a_public" {
  count = length(local.public_subnets_vpc_a)
  vpc_id            = aws_vpc.vpc_a.id
  cidr_block        = local.public_subnets_vpc_a[count.index].cidr
  availability_zone = local.public_subnets_vpc_a[count.index].zone
  map_public_ip_on_launch = true
  tags = {
     Name = format(
         "%s-%s-%s-vpc_a-%s",
         var.company,
         var.environment,
         local.public_subnets_vpc_a[count.index].purpose,
         element(split("", local.public_subnets_vpc_a[count.index].zone), length(local.public_subnets_vpc_a[count.index].zone) - 1)
     )
   }
}
resource "aws_route_table_association" "vpc_a_public" {
  count = length(aws_subnet.vpc_a_public)
  subnet_id      = aws_subnet.vpc_a_public[count.index].id
  route_table_id = aws_route_table.vpc_a_public.id
}
