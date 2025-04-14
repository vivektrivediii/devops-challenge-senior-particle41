################################################################################
# VPC
################################################################################
resource "aws_vpc" "vpc" {
  cidr_block            = var.cidr
  instance_tenancy      = var.instance_tenancy
  enable_dns_hostnames  = var.enable_dns_hostnames
  enable_dns_support    = var.enable_dns_support

  tags = merge(
    {
      Name = "${var.name}-vpc"
    },
    var.tags,
    var.vpc_tags,
  )
}

################################################################################
# Internet Gateway
################################################################################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    {
      Name = "${var.name}-igw"
    },
    var.tags,
  )
}

################################################################################
# NAT Gateway
################################################################################
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public[0].id  # Reference the first public subnet directly

  tags = merge(
    {
      Name = "${var.name}-nat-gateway"
    },
    var.tags,
  )
}

resource "aws_eip" "nat_eip" {
  depends_on = [aws_internet_gateway.igw]

  tags = merge(
    {
      Name = "${var.name}-natgw-eip"
    },
    var.tags,
  )
}

################################################################################
# Publiс Subnets
################################################################################
resource "aws_subnet" "public" {
  for_each = { for idx, cidr in var.public_subnets : idx => cidr }

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value
  availability_zone       = element(var.azs, each.key)
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = merge(
    {
      Name = "${var.name}-${var.public_subnet_suffix}-${element(var.azs, each.key)}"
    },
    var.tags,
    var.public_subnet_tags
  )
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(
    {
      Name = "${var.name}-public-rt"
    },
    var.tags,
    var.public_route_table_tags,
  )
}

resource "aws_route_table_association" "public_subnet" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

################################################################################
# Private Subnets
################################################################################
resource "aws_subnet" "private" {
  for_each = { for idx, cidr in var.private_subnets : idx => cidr }

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value
  availability_zone = element(var.azs, each.key)

  tags = merge(
    {
      Name = "${var.name}-${var.private_subnet_suffix}-${element(var.azs, each.key)}"
    },
    var.tags,
    var.private_subnet_tags
  )
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = merge(
    {
      Name = "${var.name}-private-rt"
    },
    var.tags,
    var.private_route_table_tags,
  )
}

resource "aws_route_table_association" "private_subnet" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}