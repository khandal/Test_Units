output "AmazonEKSClusterPolicy" {
  value = aws_iam_role_policy_attachment.eks-AmazonEKSClusterPolicy.policy_arn
}
output "eks_AmazonEKSVPCResourceController" {
  value = aws_iam_role_policy_attachment.eks-AmazonEKSVPCResourceController.policy_arn
}
output "eks_master_role" {
  value = aws_iam_role.eks_master_role.arn
}
output "eks_nodegroup_role" {
  value = aws_iam_role.eks_nodegroup_role.arn
}
output "eks_AmazonEKSWorkerNodePolicy" {
  value = aws_iam_role_policy_attachment.eks-AmazonEKSWorkerNodePolicy.policy_arn
}
output "eks_AmazonEKS_CNI_Policy" {
  value = aws_iam_role_policy_attachment.eks-AmazonEKS_CNI_Policy.policy_arn
}
output "eks_AmazonEC2ContainerRegistryRindiadOnly" {
  value = aws_iam_role_policy_attachment.eks-AmazonEC2ContainerRegistryRindiadOnly.policy_arn
}