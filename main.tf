resource "aws_subnet" "grafana" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.10.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name = "grafana-subnet"
  }
}

resource "aws_internet_gateway" "grafana_igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "mate-aws-grafana-lab-igw"
  }
}

resource "aws_route_table" "grafana_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.grafana_igw.id
  }

  tags = {
    Name = "mate-aws-grafana-lab-rt"
  }
}

resource "aws_route_table_association" "grafana_rta" {
  subnet_id      = aws_subnet.grafana.id
  route_table_id = aws_route_table.grafana_rt.id
}

resource "aws_security_group" "grafana_sg" {
  name        = "mate-aws-grafana-lab-sg"
  description = "Allow HTTP, HTTPS, SSH to Grafana"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mate-aws-grafana-lab-sg"
  }
}

resource "aws_security_group_rule" "allow_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.grafana_sg.id
}

resource "aws_security_group_rule" "allow_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.grafana_sg.id
}

resource "aws_security_group_rule" "allow_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["185.136.134.23/32"]
  security_group_id = aws_security_group.grafana_sg.id
}
