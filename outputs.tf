output "cluster_name" {
  value = aws_eks_cluster.this.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "cluster_certificate_authority_data" {
  value = aws_eks_cluster.this.certificate_authority[0].data
}

output "node_group_arn" {
  value = aws_eks_node_group.nodes.arn
}

output "public_subnets" {
  value = [for s in aws_subnet.public : s.id]
}

output "vpc_id" {
  value = aws_vpc.this.id
}
