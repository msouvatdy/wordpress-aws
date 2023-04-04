output "wordpress_ip" {
  value = aws_instance.instance.public_ip
}