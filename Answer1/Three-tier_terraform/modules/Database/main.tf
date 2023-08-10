resource "aws_db_instance" "rds_db" {
  allocated_storage      = var.db_storage
  engine                 = "postgres"
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  db_name                = var.db_name
  username               = var.dbuser
  password               = var.dbpassword
  db_subnet_group_name   = "${var.db_subnet_group_name[0]}"
  identifier             = var.db_identifier
  skip_final_snapshot    = var.skip_db_snapshot
  vpc_security_group_ids = [var.rds_sg]
  port                   = var.db_port
  parameter_group_name   = aws_db_parameter_group.parameter_group.name
  apply_immediately      = true


  tags = merge(
    var.additional_tags,
    {
      Name = "${var.name}-RDS-Mysql"
    }
  )
}