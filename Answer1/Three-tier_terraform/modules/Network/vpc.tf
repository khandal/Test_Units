### CUSTOM VPC CONFIGURATION

resource "random_integer" "random" {
  min = 1
  max = 100
}

resource "aws_vpc" "india_dev_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(
    var.additional_tags,
    {
      Name = "${var.name}-VPC"
    }
  )
  lifecycle {
    create_before_destroy = true
  }
}

data "aws_availability_zones" "available" {
}

### INTERNET GATEWAY

resource "aws_internet_gateway" "india_dev_internet_gateway" {
  vpc_id = aws_vpc.india_dev_vpc.id

  tags = merge(
    var.additional_tags,
    {
      Name = "${var.name}-Internet-Gateway"
    }
  )
  lifecycle {
    create_before_destroy = true
  }
}


### PUBLIC SUBNETS (WEB TIER) AND ASSOCIATED ROUTE TABLES

resource "aws_subnet" "india_dev_public_subnets" {
  count                   = var.public_sn_count
  vpc_id                  = aws_vpc.india_dev_vpc.id
  cidr_block              = "10.0.${10 + count.index}.0/24"
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = merge(
    var.additional_tags,
    {
      Name = "${var.name}-Public-Subnet"
    }
  )

}

resource "aws_route_table" "india_dev_public_rt" {
  vpc_id = aws_vpc.india_dev_vpc.id

  tags = merge(
    var.additional_tags,
    {
      Name = "${var.name}-Route-Table"
    }
  )
}

resource "aws_route" "default_public_route" {
  route_table_id         = aws_route_table.india_dev_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.india_dev_internet_gateway.id
}

resource "aws_route_table_association" "india_dev_public_assoc" {
  count          = var.public_sn_count
  subnet_id      = aws_subnet.india_dev_public_subnets.*.id[count.index]
  route_table_id = aws_route_table.india_dev_public_rt.id

}


### EIP AND NAT GATEWAY

resource "aws_eip" "india_dev_nat_eip" {
  tags = merge(
    var.additional_tags,
    {
      Name = "${var.name}-EIP"
    }
  )
}

resource "aws_nat_gateway" "india_dev_ngw" {
  allocation_id = aws_eip.india_dev_nat_eip.id
  subnet_id     = aws_subnet.india_dev_public_subnets[1].id

  tags = merge(
    var.additional_tags,
    {
      Name = "${var.name}-Nat-Gateway"
    }
  )
}


### PRIVATE SUBNETS (APP TIER & DATABASE TIER) AND ASSOCIATED ROUTE TABLES

resource "aws_subnet" "india_dev_private_subnets" {
  count                   = var.private_sn_count
  vpc_id                  = aws_vpc.india_dev_vpc.id
  cidr_block              = "10.0.${20 + count.index}.0/24"
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = merge(
    var.additional_tags,
    {
      Name = "${var.name}-Private-Subnet"
    }
  )
}

resource "aws_route_table" "india_dev_private_rt" {
  vpc_id = aws_vpc.india_dev_vpc.id

  tags = merge(
    var.additional_tags,
    {
      Name = "${var.name}-Private-RouteTable"
    }
  )
}

resource "aws_route" "default_private_route" {
  route_table_id         = aws_route_table.india_dev_private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.india_dev_ngw.id
}


resource "aws_route_table_association" "india_dev_private_assoc" {
  count          = var.private_sn_count
  route_table_id = aws_route_table.india_dev_private_rt.id
  subnet_id      = aws_subnet.india_dev_private_subnets.*.id[count.index]
}

resource "aws_elasticache_subnet_group" "india_dev_elasticache_subnet_group" {
  name       = "${var.name}-radis-subnet-group"
  count      = var.db_subnet_group == true ? 1 : 0
  subnet_ids = [aws_subnet.india_dev_private_subnets[0].id, aws_subnet.india_dev_private_subnets[1].id]

  tags = var.additional_tags
}

resource "aws_db_subnet_group" "dev_rds_subnetgroup" {
  name       = "${var.name}-rds-subnet-group"
  subnet_ids = [aws_subnet.india_dev_private_subnets[0].id, aws_subnet.india_dev_private_subnets[1].id]

  tags = var.additional_tags
}
