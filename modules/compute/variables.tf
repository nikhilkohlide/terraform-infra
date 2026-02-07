variable "project_name" {
  type = string
}

variable "private_subnets" {
  type = list(string)

}


variable "public_subnets" {
  type = list(string)
}


variable "vpc_id" {
  type = string
}
variable "allowed_ssh_cidr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}
