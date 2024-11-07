resource "aws_vpc" "my_vpc" {
  cidr_block         = var.vpc_info.cidr_block
  enable_dns_support = var.vpc_info.enable_dns_Support
  tags               = merge(var.vpc_info.tags, { "name" = var.vpc_info.name })
}