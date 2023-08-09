provider "aws" {
  region = "us-east-1"
}
# terraform {
#   backend "s3" {
#     bucket = "terrafrom-tf-state"
#     key    = "eks/eks.tf"
#     region = "us-east-1"
#   }
# }

module "Network" {
  source           = "./modules/Network"
  name             = var.name
  vpc_cidr         = var.vpc_cidr
  db_subnet_group  = true
  access_ip        = var.access_ip
  additional_tags  = var.additional_tags
  public_sn_count  = var.public_sn_count
  private_sn_count = var.private_sn_count
  jenkins_Ports    = var.jenkins_Ports
  cluster_Ports    = var.cluster_Ports
  node_Ports       = var.node_Ports
}

module "IAM" {
  source = "./modules/IAM"
  name   = var.name
}

module "compute" {
  source                   = "./modules/Compute"
  name                     = var.name
  additional_tags          = var.additional_tags
  jenkins_sg               = module.Network.jenkins_sg
  india_dev_public_subnets = module.Network.india_dev_public_subnets
  jenkins_instance_type    = var.jenkins_instance_type
  ami_jenkins              = var.ami_jenkins
}

module "EKS" {
  source                                    = "./modules/EKS"
  min_size                                  = var.min_size
  max_size                                  = var.max_size
  desired_size                              = var.desired_size
  instance_types                            = var.instance_types
  disk_size                                 = var.disk_size
  eks_cluster_sg                            = module.Network.eks_cluster_sg
  node_group_sg                             = module.Network.node_group_sg
  cluster_name                              = var.cluster_name
  name                                      = var.name
  additional_tags                           = var.additional_tags
  eks_master_role                           = module.IAM.eks_master_role
  cluster_version                           = var.cluster_version
  india_dev_private_subnets                 = module.Network.india_dev_private_subnets
  cluster_service_ipv4_cidr                 = var.cluster_service_ipv4_cidr
  eks_nodegroup_role                        = module.IAM.eks_nodegroup_role
  eks_AmazonEKSVPCResourceController        = module.IAM.eks_AmazonEKSVPCResourceController
  AmazonEKSClusterPolicy                    = module.IAM.AmazonEKSClusterPolicy
  eks_AmazonEC2ContainerRegistryRindiadOnly = module.IAM.eks_AmazonEC2ContainerRegistryRindiadOnly
  eks_AmazonEKS_CNI_Policy                  = module.IAM.eks_AmazonEKS_CNI_Policy
  eks_AmazonEKSWorkerNodePolicy             = module.IAM.eks_AmazonEKSWorkerNodePolicy
}

module "Redis" {
  source                             = "./modules/Redis"
  name                               = var.name
  additional_tags                    = var.additional_tags
  redis_sg                           = module.Network.redis_sg
  india_dev_elasticache_subnet_group = module.Network.india_dev_elasticache_subnet_group
  node_type                          = var.node_type
  num_cache_nodes                    = var.num_cache_nodes
}

module "Database" {
  source               = "./modules/Database"
  db_storage           = 8
  db_engine_version    = var.db_engine_version
  db_name              = var.db_name
  db_instance_class    = var.db_instance_class
  dbuser               = var.dbuser
  dbpassword           = var.dbpassword
  db_identifier        = var.db_identifier
  db_port              = var.db_port
  skip_db_snapshot     = true
  rds_sg               = module.Network.rds_sg
  db_subnet_group_name = module.Network.dev_rds_subnetgroup
  additional_tags      = var.additional_tags
  name                 = var.name
}
module "CodeCommit" {
  source          = "./modules/CodeCommit"
  name            = var.name
  additional_tags = var.additional_tags
}
module "s3" {
  source          = "./modules/S3"
  name            = var.name
  additional_tags = var.additional_tags
}