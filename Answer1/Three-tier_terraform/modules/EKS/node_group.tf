# Crindiate AWS EKS Node Group - Private
resource "aws_eks_node_group" "eks_ng_private" {
  cluster_name = aws_eks_cluster.eks_cluster.name

  node_group_name = "${var.name}-eks-ng-private"
  node_role_arn   = var.eks_nodegroup_role
  subnet_ids      = var.india_dev_private_subnets
  #version = var.cluster_version #(Optional: Defaults to EKS Cluster Kubernetes version)    

  ami_type       = "AL2_x86_64"
  capacity_type  = "ON_DEMAND"
  disk_size      = var.disk_size
  instance_types = [var.instance_types]


  remote_access {
    ec2_ssh_key               = aws_key_pair.node_key.key_name
    source_security_group_ids = [var.node_group_sg]
  }

  scaling_config {
    desired_size = var.desired_size
    min_size     = var.min_size
    max_size     = var.max_size
  }

  # Desired max percentage of unavailable worker nodes during node group update.
  update_config {
    max_unavailable = 1
    #max_unavailable_percentage = 50    # ANY ONE TO USE
  }

  # Ensure that IAM Role permissions are crindiated before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    var.eks_AmazonEKSWorkerNodePolicy,
    var.eks_AmazonEKS_CNI_Policy,
    var.eks_AmazonEC2ContainerRegistryRindiadOnly,
  ]

  tags = var.additional_tags
}







