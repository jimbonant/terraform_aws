
# Creating Private Subnets in VPC
resource "aws_subnet" "dev-private-1" {
  vpc_id                  = aws_vpc.dev.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-2a"

  tags = {
    Name = "dev-private-1"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/role/internal-elb" = "owned"
  }
}

resource "aws_subnet" "dev-private-2" {
  vpc_id                  = aws_vpc.dev.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-2b"

  tags = {
    Name = "dev-private-2"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/role/internal-elb" = "owned"
  }
}

resource "aws_subnet" "dev-private-3" {
  vpc_id                  = aws_vpc.dev.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-2c"

  tags = {
    Name = "dev-private-3"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/role/internal-elb" = "owned"
  }
}

resource "aws_subnet" "dev-public-1" {
  vpc_id                  = aws_vpc.dev.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-2c"

  tags = {
    Name = "dev-public-1"
  }
}

# Creating Internet Gateway in AWS VPC
resource "aws_internet_gateway" "dev-gw" {
  vpc_id = aws_vpc.dev.id

  tags = {
    Name = "dev-gw"
  }
}

resource "aws_nat_gateway" "nat"{
  allocation_id = aws_eip.nat.id
  subnet_id = aws_subnet.dev-public-1.id

  tags = {
    Name = "nat"
  }

  depends_on = [aws_internet_gateway.dev-gw]

}

resource "aws_eip" "nat" {
  vpc = true
  tags = {
    Name = "EIP-nat"
  }
}


# Creating Route Tables for Internet nat gateway
resource "aws_route_table" "dev-private-1" {
  vpc_id = aws_vpc.dev.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gateway-1.id
  }

  tags = {
    Name = "Route Table dev-private-1"
  }
}

resource "aws_route_table" "dev-private-2" {
  vpc_id = aws_vpc.dev.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gateway-2.id
  }

  tags = {
    Name = "Route Table dev-private-2"
  }
}

resource "aws_route_table" "dev-private-3" {
  vpc_id = aws_vpc.dev.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gateway-3.id
  }

  tags = {
    Name = "Route Table dev-private-3"
  }
}

# Creating Route Associations private subnets
resource "aws_route_table_association" "dev-private-1-a" {
  subnet_id      = aws_subnet.dev-private-1.id
  route_table_id = aws_route_table.dev-private-1.id
}

resource "aws_route_table_association" "dev-private-2-a" {
  subnet_id      = aws_subnet.dev-private-2.id
  route_table_id = aws_route_table.dev-private-2.id
}

resource "aws_route_table_association" "dev-private-3-a" {
  subnet_id      = aws_subnet.dev-private-3.id
  route_table_id = aws_route_table.dev-private-3.id
}



resource "aws_eip" "eip-for-nat-gateway-1" {
  vpc = true
  tags = {
    Name = "EIP-1"
  }
}

resource "aws_nat_gateway" "nat-gateway-1" {
  allocation_id     = aws_eip.eip-for-nat-gateway-1.id
  subnet_id         = aws_subnet.dev-private-1.id

  tags = {
    Name = "Nat Gateway Private Subnet 1" 
  }
}

resource "aws_eip" "eip-for-nat-gateway-2" {
  vpc = true
  tags = {
    Name = "EIP-2"
  }
}

resource "aws_nat_gateway" "nat-gateway-2" {
  allocation_id     = aws_eip.eip-for-nat-gateway-2.id
  subnet_id         = aws_subnet.dev-private-2.id

  tags = {
    Name = "Nat Gateway Private Subnet 2" 
  }
}

resource "aws_eip" "eip-for-nat-gateway-3" {
  vpc = true
  tags = {
    Name = "EIP-3"
  }
}

resource "aws_nat_gateway" "nat-gateway-3" {
  allocation_id     = aws_eip.eip-for-nat-gateway-3.id
  subnet_id         = aws_subnet.dev-private-3.id

  tags = {
    Name = "Nat Gateway Private Subnet 3" 
  }
}