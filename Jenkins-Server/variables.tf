variable "cidr_range" {
    description = "this is vpc cidr value"
    type = string
    default = "192.0.0.0/16"
}

variable "subnet_cidr" {
    description = "this is subnet cidr"
    type = list(string)
}

variable "instance_type" {
  description = "This is Jenkins server instance type"
  type = string
  default = "t2.micro"
}

variable "key_name" {
  description = "this key pair of the server name"
  type = string
}