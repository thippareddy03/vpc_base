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