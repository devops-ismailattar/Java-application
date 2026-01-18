variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "azs" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}


variable "public_subnet_names" {
  type = list(string)
}

variable "private_subnet_names" {
  type = list(string)
}

variable "private_subnet_tags" {
  type = map(string)

}

variable "public_subnet_tags" {
  type = map(string)
  
}

variable "nat_gateway_tags" {
    type = map(string)
  
}

variable "EKS_cluster_name" {
    type = string
  
}




