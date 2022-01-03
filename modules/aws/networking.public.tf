#######
# VPC #
#######

resource "aws_vpc" "lab_vpc" {
  cidr_block           = var.cidr_vpc
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name                                        = "lab VPC-${var.tfuser}"
    Owner                                       = var.tfuser
    "kubernetes.io/cluster/${var.name}" = "owned"
  }
}

###########
# SUBNETS #
###########

data "aws_availability_zones" "available_azs" {
  state = "available"
}

resource "aws_subnet" "lab_public_subnet_1" {
  vpc_id            = aws_vpc.lab_vpc.id
  availability_zone = data.aws_availability_zones.available_azs.names[0]
  cidr_block        = var.cidr_public_subnet_1

  tags = {
    Name                                        = "lab Public Subnet 1-${var.tfuser}"
    "kubernetes.io/cluster/${var.name}" = "owned"
    "KubernetesCluster"                         = var.name
    "kubernetes.io/role/elb"                    = ""
    Owner                                       = var.tfuser
  }
}

resource "aws_subnet" "lab_public_subnet_2" {
  vpc_id            = aws_vpc.lab_vpc.id
  availability_zone = data.aws_availability_zones.available_azs.names[1]
  cidr_block        = var.cidr_public_subnet_2

  tags = {
    Name                                        = "lab Public Subnet 2-${var.tfuser}"
    "kubernetes.io/cluster/${var.name}" = "owned"
    "KubernetesCluster"                         = var.name
    "kubernetes.io/role/elb"                    = ""
    Owner                                       = var.tfuser
  }
}

############
# GATEWAYS #
############

resource "aws_internet_gateway" "lab_igw" {
  vpc_id = aws_vpc.lab_vpc.id

  tags = {
    Name  = "lab IGW-${var.tfuser}"
    Owner = var.tfuser
  }
}

################
# ROUTE TABLES #
################

resource "aws_route_table" "lab_public_rt" {
  vpc_id = aws_vpc.lab_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lab_igw.id
  }

  tags = {
    Name = "lab Public Route Table-${var.tfuser}"
    Owner = var.tfuser
  }
}

resource "aws_route_table_association" "lab_public_rt_assoc_1" {
  subnet_id      = aws_subnet.lab_public_subnet_1.id
  route_table_id = aws_route_table.lab_public_rt.id
}

resource "aws_route_table_association" "lab_public_rt_assoc_2" {
  subnet_id      = aws_subnet.lab_public_subnet_2.id
  route_table_id = aws_route_table.lab_public_rt.id
}
