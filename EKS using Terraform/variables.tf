variable "cidr_range" {
    description = "this is vpc cidr value"
    type = string
    default = "192.0.0.0/16"
}

variable "subnet_cidr" {
    description = "this is subnet cidr"
    type = list(string)
}

variable "private_subnets" {
  description = "this are the subnets cidr of the private subnets"
  type = list(string)
}
