variable "db_password" {
  description = "PostgreSQL database user password"
  type        = string
  sensitive   = true
}

variable "db_host" {
  description = "Private IP of the database VM"
  type        = string
}
