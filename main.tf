variable "public_key" {
  default = "terraform-key.pub"
}

resource "aws_key_pair" "key_pair" {
  public_key = file(var.public_key)
  tags = {
    Formation = "FinOps AWS"
  }
  lifecycle {
    create_before_destroy = true
  }
}

module "wordpress_terraform" {
    #source path to the module file
    source = "/home/ubuntu/wordpress-aws/module"
    public_key = aws_key_pair.key_pair.key_name
}

output "wordpress ip_address" {
    value = module.wordpress_terraform.wordpress_ip
} 