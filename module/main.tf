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
  availability_zone = "us-east-2a"
  tags = {
    Name = var.personal_name
    Formation = var.personal_name
  }
}

resource "aws_ebs_volume" "bdd_wordpress" {
  availability_zone = "us-east-2a"
  size              = 20
  tags = {
    Name = var.personal_name
    Formation = var.personal_name
  }
}

resource "aws_ebs_volume" "site_wordpress" {
  availability_zone = "us-east-2a"
  size              = 20
  tags = {
    Name = var.personal_name
    Formation = var.personal_name
  }
}


resource "aws_instance" "instance" {
  #for_each               = toset(var.instance_names)

  #user_data = <<-EOF
  #              sudo hostname ${each.value}
  #              echo ${each.value} | sudo tee /etc/hostname
  #              EOF
  ami                    = data.aws_ami.ubuntu.image_id
  instance_type          = "t2.medium"
  subnet_id              = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.allow_http.id]
  key_name               = var.public_key
  
  tags = {
    Name = var.personal_name
    Formation = var.personal_name
  }
}

resource "aws_volume_attachment" "bdd_wordpress" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.bdd_wordpress.id
  instance_id = aws_instance.instance.id
}

resource "aws_volume_attachment" "site_wordpress" {
  device_name = "/dev/sdi"
  volume_id   = aws_ebs_volume.site_wordpress.id
  instance_id = aws_instance.instance.id
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = var.personal_name
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
  name        = var.personal_name
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

resource "aws_efs_file_system" "Wordpress_EFS_FinOps" {
  availability_zone_name = "us-east-2a"
  lifecycle_policy {
    transition_to_ia = "AFTER_90_DAYS"
  }
 tags = {
    Name = var.personal_name
    Formation = var.personal_name
 }
}

resource "aws_efs_access_point" "wordpress" {
  file_system_id = aws_efs_file_system.Wordpress_EFS_FinOps.id
  root_directory {
    path = "/wordpress"
    creation_info {
      owner_gid   = 0
      owner_uid   = 0
      permissions = 0777
    }
 }
}

resource "aws_efs_access_point" "mysql" {
  file_system_id = aws_efs_file_system.Wordpress_EFS_FinOps.id
  root_directory {
    path = "/mysql"
    creation_info {
      owner_gid   = 0
      owner_uid   = 0
      permissions = 0777
    }
  }
}

resource "aws_efs_backup_policy" "policy_FinOps" {
  file_system_id = aws_efs_file_system.Wordpress_EFS_FinOps.id
  backup_policy {
    status = "ENABLED"
  }
}

resource "aws_efs_mount_target" "FinOps_Wordpress" {
  file_system_id  = aws_efs_file_system.Wordpress_EFS_FinOps.id
  subnet_id       = aws_subnet.main.id
  security_groups = [aws_security_group.allow_http.id]
}