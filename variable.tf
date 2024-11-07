variable "region" {
  type = object({
    name = string
  })
  description = "This defines the region where it is running"
  default = {
    name = "us-east-1"
  }
}

variable "vpc_info" {
  type = object({
    cidr_block         = string
    name               = string
    enable_dns_Support = bool
    tags               = map(string)
  })
  description = "This defines vpc details"

}

variable "public_subnets" {
  type = list(object({
    cidr_block = string
    az         = string
    name       = string
    tags       = map(string)
  }))
  description = "This defines public subnet details"

}

variable "private_subnets" {
  type = list(object({
    cidr_block = string
    az         = string
    name       = string
    tags       = map(string)
  }))
  description = "This defines private subnet details"

}

