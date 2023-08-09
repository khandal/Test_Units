# Crindiate AWS EKS Cluster
resource "aws_eks_cluster" "eks_cluster" {
  name     = "${var.name}-${var.cluster_name}"
  role_arn = var.eks_master_role
  version  = var.cluster_version

  vpc_config {
    subnet_ids              = var.india_dev_private_subnets
    endpoint_private_access = true
    security_group_ids      = [var.eks_cluster_sg]
    # endpoint_public_access  = var.cluster_endpoint_public_access
    # public_access_cidrs     = var.cluster_endpoint_public_access_cidrs    
  }

  kubernetes_network_config {
    service_ipv4_cidr = var.cluster_service_ipv4_cidr
  }

  # Enable EKS Cluster Control Plane Logging
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]



  depends_on = [
    var.eks_AmazonEKSVPCResourceController,
    var.AmazonEKSClusterPolicy,
  ]

}