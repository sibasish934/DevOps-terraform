#vpc # if the we use the module then  the other components of the vpc will automatically be created.
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "Jenkins-vpc"
  cidr = var.cidr_range

  azs             = data.aws_availability_zones.azs.names
  public_subnets  = var.subnet_cidr
  map_public_ip_on_launch = true

  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Terraform = "true"
    Environment = "dev"
    Name = "Jenkins-Terraform-VPC"
  }

  public_subnet_tags = {
    Name = "Jenkins-Terraform-vpc-subnet"
  }

  public_route_table_tags = {
    Name = "Jenkins-Terraform-vpc-subnet-rt"
  }

}

#sg
module "Jenkins_service_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "Jenkins-SG"
  description = "SG that Allows the traffic Jenkins Server"
  vpc_id      =  module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "HTTP"
      cidr_blocks = "150.107.26.5/32"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "SSH"
      cidr_blocks = "150.107.26.5/32"
    }
  ]

  egress_with_cidr_blocks = [
    {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = "0.0.0.0/0"
    }
  ]

  tags = {
    Name = "Jenkins-SG"
  }
}

#EC2 Instance

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "Jenkins-Server"

  instance_type          = var.instance_type
  key_name               = var.key_name
  monitoring             = true
  vpc_security_group_ids = [module.Jenkins_service_sg.security_group_id]
  subnet_id              = module.vpc.public_subnets[1]
  associate_public_ip_address = true
  
  user_data = file("Jenkins-install.sh")
  availability_zone = data.aws_availability_zones.azs.names[1]

  tags = {
    Name = "Jenkins-Server"
    Terraform   = "true"
    Environment = "dev"
  }
}
