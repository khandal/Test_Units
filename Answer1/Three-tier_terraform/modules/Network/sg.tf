resource "aws_security_group" "jenkins_sg" {
  name   = "${var.name}-jenkins-sg"
  vpc_id = aws_vpc.india_dev_vpc.id

  dynamic "ingress" { #incoming rule
    for_each = var.jenkins_Ports
    iterator = port
    content {
      description = "TLS from VPC"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = var.access_ip
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.additional_tags
}


resource "aws_security_group" "eks_cluster_sg" {
  name   = "${var.name}-eks-cluster-sg"
  vpc_id = aws_vpc.india_dev_vpc.id

  dynamic "ingress" { #incoming rule
    for_each = var.cluster_Ports
    iterator = port
    content {
      description     = "TLS from VPC"
      from_port       = port.value
      to_port         = port.value
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = [aws_security_group.jenkins_sg.id]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.additional_tags
}

resource "aws_security_group" "node_group_sg" {
  name   = "${var.name}-node-group-sg"
  vpc_id = aws_vpc.india_dev_vpc.id

  dynamic "ingress" { #incoming rule
    for_each = var.node_Ports
    iterator = port
    content {
      description     = "TLS from VPC"
      from_port       = port.value
      to_port         = port.value
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = [aws_security_group.jenkins_sg.id]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.additional_tags
}

resource "aws_security_group" "redis_sg" {
  name   = "${var.name}-redis-SG"
  vpc_id = aws_vpc.india_dev_vpc.id

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = [aws_security_group.jenkins_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.additional_tags
}
resource "aws_security_group" "rds_sg" {
  name   = "${var.name}-RDS-SG"
  vpc_id = aws_vpc.india_dev_vpc.id
  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.jenkins_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.additional_tags
}