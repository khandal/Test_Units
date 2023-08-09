resource "aws_db_parameter_group" "parameter_group" {
  name   = "${var.name}-parameter-group"
  family = "postgres15"

  parameter {
    name  = "rds.force_ssl"
    value = "0"
  }
}