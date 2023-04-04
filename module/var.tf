variable "instance_names" {
  default = ["wordpress", "mysql"]
}

variable "public_key" {
  type        = string
  description = "Cle publique a injecter dans les instances"
}

variable "personal_name" {
  default = "Formation FinOps"
  description = "Valeur du TAG user pour toutes les ressources créer par terraform"
}