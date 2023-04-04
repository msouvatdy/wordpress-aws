resource "aws_vpc" "main" {
  cidr_block       = "10.20.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = true
  tags = {
    Name = "FinOps-wordpress"
    Formation = var.personal_name
  }
}

resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.20.30.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "subnetFinOps-wordpress"
    Formation = var.personal_name
  }
}



resource "aws_instance" "instance" {
  for_each               = toset(var.instance_names)
  user_data = <<-EOF
                sudo hostname ${each.value}
                echo ${each.value} | sudo tee /etc/hostname
                EOF
  ami                    = data.aws_ami.ubuntu.image_id
  instance_type          = "t2.medium"
  subnet_id              = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.allow_http.id]
  key_name               = var.public_key
  
  tags = {
    Name = each.value
    Formation = var.personal_name
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "gw-FinOps-wordpress"
    Formation = var.personal_name
  }
}

resource "aws_route" "r" {
  route_table_id         = data.aws_route_table.selected.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_security_group" "allow_http" {
  vpc_id      = aws_vpc.main.id
  name        = "FinOps-wordpress"
  description = "FinOps"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  lifecycle {
    create_before_destroy = true
  }
}