data "aws_ami" "ubuntu" {
  owners      = ["self"]
  most_recent = true

  filter {
    name   = "name"
    values = ["FINOPS-TERRAFORM"]
  }
}

data "aws_route_table" "selected" {
  vpc_id = aws_vpc.main.id
}