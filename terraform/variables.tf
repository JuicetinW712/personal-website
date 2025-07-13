variable "project_name" {
  type = string
}

variable "region" {
  type = string
  default = "us-east-1"
}

variable "domain_name" {
  description = "Domain name for website"
  type = string
}