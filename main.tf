resource "aws_vpc" "my_vpc" {
  cidr_block         = var.vpc_info.cidr_block
  enable_dns_support = var.vpc_info.enable_dns_Support
  tags               = merge(var.vpc_info.tags, { "Name" = var.vpc_info.name })
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.my_vpc.id
  count             = length(var.public_subnets)
  cidr_block        = var.public_subnets[count.index].cidr_block
  availability_zone = var.public_subnets[count.index].az
  tags              = merge(var.public_subnets[count.index].tags, { "Name" = var.public_subnets[count.index].name })

}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.my_vpc.id
  count             = length(var.private_subnets)
  cidr_block        = var.private_subnets[count.index].cidr_block
  availability_zone = var.private_subnets[count.index].az
  tags              = merge(var.private_subnets[count.index].tags, { "Name" = var.private_subnets[count.index].name })

}