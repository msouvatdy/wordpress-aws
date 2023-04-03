variable "instance_names" {
  default = ["wordpress", "mysql"]
}

variable "public_key" {
  type        = string
  description = "Cle publique a injecter dans les instances"
}