vpc_cidr = "10.0.0.0/16"
vpc_name = "EKS"

public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", ]
private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]

private_subnet_names = ["Private_SubnetA", "Private_SubnetB"]
public_subnet_names  = ["Public_SubnetA", "Public_SubnetB"]

private_subnet_tags = {
  "kubernetes.io/role/internal-elb" = "1"
  "kubernetes.io/cluster/eks_vpc"   = "shared"
}

public_subnet_tags = {
  "kubernetes.io/role/elb"        = "1"
  "kubernetes.io/cluster/eks_vpc" = "shared"
}


EKS_cluster_name = "EKSAPI1"

azs = ["ap-south-1a", "ap-south-1b"]

nat_gateway_tags = {
  "Name" = "EKS_NG"
}