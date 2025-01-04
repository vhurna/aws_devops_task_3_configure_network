# Add your code here

# 1. Create a subnet 
resource "aws_subnet" "grafana_subnet" {
  vpc_id     = var.vpc_id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "grafana"
  }
}

# 2. Create an Internet Gateway and attach it to the vpc
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = var.vpc_id

  tags = {
    Name = "mate-aws-grafana-lab"
  }
}

# 3. Configure routing for the Internet Gateway
resource "aws_route_table" "route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "mate-aws-grafana-lab"
  }
}
resource "aws_route_table_association" "grafana_subnet" {
  subnet_id      = aws_subnet.grafana_subnet.id
  route_table_id = aws_route_table.route_table.id
}

# 4. Create a Security Group 
resource "aws_security_group" "security_group" {
  name        = "mate-aws-grafana-lab"
  description = "Rules for Mate AWS Grafana lab"
  vpc_id      = var.vpc_id

  tags = {
    Name = "mate-aws-grafana-lab"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.security_group.id
  cidr_ipv4         = "95.158.53.223/32"
  ip_protocol       = "tcp"
  to_port           = 22
}
