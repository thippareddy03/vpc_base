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
# Creating internet gate way
resource "aws_internet_gateway" "Internet_gateway" {
  count = length(var.public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "Internet_Gateway"
  }
  
}
#creating public route table

resource "aws_route_table" "public" {
  count = length(var.public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "Public Route table"
  }
}

#Assocaiate public subnets with public route table
resource "aws_route_table_association" "public" {
  count = length(var.public_subnets) > 0 ? 1 : 0
  subnet_id = var.public_subnets[count.index].id
  route_table_id = aws_route_table.public.id
  
}

# create a route to internet gateway in public route table

resource "aws_route" "Internet" {
  count = length(var.public_subnets) > 0 ? 1 : 0
  route_table_id = aws_route_table.public[0].id
  gateway_id = aws_internet_gateway.Internet_gateway[0].id
  destination_cidr_block = "0.0.0.0/0"
  
}

#creating private route table

resource "aws_route_table" "private" {
  count = length(var.private_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "Private Route table"
  }
  
}

#Assocaiate private subnets with private route table

resource "aws_route_table_association" "private" {
  count = length(var.private_subnets) >  0 ? 1 : 0
  subnet_id = var.private_subnets[count.index].id
  route_table_id = aws_route_table.private.id
  
}
