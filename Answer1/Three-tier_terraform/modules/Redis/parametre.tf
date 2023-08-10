resource "aws_elasticache_parameter_group" "parametre" {
  name   = "${var.name}-parametre-group"
  family = "redis7.0"

  parameter {
    name  = "activerehashing"
    value = "yes"
  }
}