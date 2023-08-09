output "jenkins_sg" {
  value = aws_security_group.jenkins_sg.id
}
output "redis_sg" {
  value = aws_security_group.redis_sg.id
}
output "india_dev_public_subnets" {
  value = aws_subnet.india_dev_public_subnets[*].id
}
output "india_dev_private_subnets" {
  value = aws_subnet.india_dev_private_subnets[*].id
}
output "india_dev_elasticache_subnet_group" {
  value = aws_elasticache_subnet_group.india_dev_elasticache_subnet_group.*.id
}

output "dev_rds_subnetgroup" {
  value = aws_db_subnet_group.dev_rds_subnetgroup.*.id
}
output "rds_sg" {
  value = aws_security_group.rds_sg.id
}
output "eks_cluster_sg" {
  value = aws_security_group.eks_cluster_sg.id
}

output "node_group_sg" {
  value = aws_security_group.node_group_sg.id
}