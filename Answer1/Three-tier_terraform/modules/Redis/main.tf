resource "aws_elasticache_cluster" "dev_redis" {
  cluster_id           = "${var.name}-redis"
  engine               = "redis"
  node_type            = var.node_type
  num_cache_nodes      = var.num_cache_nodes
  parameter_group_name = aws_elasticache_parameter_group.parametre.name
  engine_version       = "7.0"
  port                 = 6379
  subnet_group_name    = "${var.india_dev_elasticache_subnet_group[0]}"
  security_group_ids   = ["${var.redis_sg}"]
  apply_immediately    = true

  tags = var.additional_tags
}

