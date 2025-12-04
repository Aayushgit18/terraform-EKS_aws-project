resource "aws_eks_node_group" "nodes" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.cluster_name}-ng"
  node_role_arn   = aws_iam_role.eks_node_role.arn

  subnet_ids = [for s in aws_subnet.public : s.id]

  scaling_config {
    desired_size = var.node_count
    max_size     = var.node_count
    min_size     = 1
  }

  instance_types = [var.node_instance_type]
  disk_size      = 20

  # OPTIONAL: SSH access into nodes
  # Replace "" with your EC2 key name (e.g., ansible-key)
  remote_access {
    ec2_ssh_key = ""
  }

  tags = merge(var.tags, {
    Name = "${var.cluster_name}-ng"
  })

  depends_on = [
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly,
  ]
}