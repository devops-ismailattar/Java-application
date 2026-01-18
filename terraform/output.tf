output "vpc_id" {
    value = module.vpc.vpc_id
}

output "public_subnet_id" {
    value = module.vpc.public_subnets
  
}

output "private_subnets_id" {
    value = module.vpc.private_subnets
  
}

output "cluster_name" {
    value = module.eks.cluster_name
  
}

output "cluster_endpoint" {
    value = module.eks.cluster_endpoint
  
}

output "cluster_oidc_issuer" {
  value = module.eks.oidc_provider
}