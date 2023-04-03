output "wordpress_ip" {
  value = aws_instance.instance[element(var.instance_names,0)].public_ip
}

output "mysql_ip" {
  value = aws_instance.instance[element(var.instance_names,1)].public_ip
}