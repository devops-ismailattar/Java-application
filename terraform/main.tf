module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.5.1"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  public_subnet_names  = var.public_subnet_names
  private_subnet_names = var.private_subnet_names

  private_subnet_tags = var.private_subnet_tags
  public_subnet_tags  = var.public_subnet_tags

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  nat_gateway_tags = var.nat_gateway_tags

  tags = {

    Project     = "EKS"
    ENVIRONEMNT = "DEV"
  }
}

#----------------EKS-----------------------------

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.11.0"

  name               = var.EKS_cluster_name
  kubernetes_version = 1.33

  endpoint_private_access       = true
  endpoint_public_access        = true
  vpc_id                        = module.vpc.vpc_id
  subnet_ids                    = module.vpc.private_subnets
  enable_irsa                   = true
  additional_security_group_ids = [aws_security_group.EKSSG.id]

  addons = {
    coredns = {
      most_recent = true
    }

    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  eks_managed_node_groups = {

    Project1 = {
      instance_types = ["t3.small"]

      min_size      = 2
      max_size      = 10
      desired_size  = 2
      capacity_type = "ON_DEMAND"

    }
  }


  access_entries = {
    admin = {
      principal_arn = "arn:aws:iam::076226033208:user/Terrafrom"
      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }

  tags = {
    Project     = "EKS"
    ENVIRONEMNT = "DEV"
  }
}

#------------------Security Group -----------------------------


resource "aws_security_group" "EKSSG" {
  vpc_id = module.vpc.vpc_id
  name   = "EKS_SG"

  ingress {
    description = "Allow Node to Node"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "EKS_SG"
    Project     = "EKS"
    ENVIRONEMNT = "DEV"

  }

}

#

resource "aws_instance" "this" {
  ami           = "ami-02b8269d5e85954ef"
  instance_type = "m7i-flex.large"
  root_block_device {
    volume_size           = 50
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

}