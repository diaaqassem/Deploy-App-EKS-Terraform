# EKS Cluster Outputs
#output "cluster_id" {
#  description = "The name/id of the EKS cluster."
#  value       = aws_eks_cluster.eks_cluster.id
#}

output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster."
  value       = aws_eks_cluster.eks_cluster.arn
}

output "cluster_endpoint" {
  description = "The endpoint for your EKS Kubernetes API."
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "node_group_public_arn" {
  description = "Private Node Group ARN"
  value       = aws_eks_node_group.eks_ng_public.arn
}
