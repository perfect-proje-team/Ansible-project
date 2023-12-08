module "vpc_main" {
  source          = "./modules/vpc"
  region_name     = "us-east-1"
  vpc_cidr_block  = "10.10.0.0/16"
  environment     = "development"
  public_subnets  = ["10.10.0.0/24", "10.10.2.0/24"]
  private_subnets = ["10.10.1.0/24", "10.10.3.0/24"]
  public_az       = ["us-east-1a", "us-east-1b"]
  private_az      = ["us-east-1a", "us-east-1b"]

}

module "S3_bucket" {
  source         = "./modules/s3"
  s3_bucket_name = "perfect-proje-team-s3-bucket"
  environment    = "development"

}

module "ec2_instance" {
  source               = "./modules/ec2"
  ami                  = "ami-0fa1ca9559f1892ec"
  instance_type        = "t2.micro"
  subnet_id            = module.vpc_main.public_subnets[1]
  iam_instance_profile = "ec2"
  ec2_name             = "webserver"
  ec2_role_name        = "webserverEC2Role"
  assume_role_policy   = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
    }
    }
  ]
}
EOT


  ec2_iam_role_policy = <<EOT
  {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws:s3:::${module.S3_bucket.bucket_name}/*",
        "arn:aws:s3:::${module.S3_bucket.bucket_name}"
      ]
    }

  ]
}
EOT
  vpc_id              = module.vpc_main.vpc_id
  environment         = "development"
}


resource "aws_iam_policy_attachment" "rds_access" {
  name = "rds-role"
  roles = [module.ec2_instance.ec2_iam_role]
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
  
}

resource "aws_security_group_rule" "http" {
  security_group_id = module.ec2_instance.security_group_id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "https" {
  security_group_id = module.ec2_instance.security_group_id
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ssh" {
  security_group_id = module.ec2_instance.security_group_id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_rds" {
  security_group_id        = module.ec2_instance.security_group_id
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.rds.db_security_group_id
}

module "rds" {
  source        = "./modules/rds"
  db_subnet_ids = module.vpc_main.private_subnets
  db_name       = "rds-database"
  user_name     = "dbadmin"
  password      = "ChangeMe1234"
  vpc_id        = module.vpc_main.vpc_id

}

resource "aws_security_group_rule" "allow_ec2" {
  security_group_id        = module.rds.db_security_group_id
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.ec2_instance.security_group_id
}
