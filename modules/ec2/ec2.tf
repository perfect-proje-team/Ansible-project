resource "aws_instance" "default" {
  ami           = var.ami
  instance_type = var.instance_type
  user_data     = var.user_data
  subnet_id     = var.subnet_id
  key_name      = var.key_name
  vpc_security_group_ids      = [aws_security_group.ec2_security_group.id]

  iam_instance_profile = var.iam_instance_profile
  tags = {
    Name        = var.ec2_name
    Environment = var.environment
  }
}

resource "aws_iam_role" "ec2_role" {
  name               = var.ec2_role_name
  assume_role_policy = var.assume_role_policy

}

resource "aws_iam_instance_profile" "default" {
  depends_on = [aws_iam_role.ec2_role]
  name       = var.iam_instance_profile
  role       = aws_iam_role.ec2_role.name
}

resource "aws_security_group" "ec2_security_group" {
  name        = var.ec2_security_group_name
  description = "security group of ec2 instance"
  vpc_id      = var.vpc_id

}

data "aws_vpcs" "main_vpc"{
  tags = {
    Name = "main_vpc"
  }
}
resource "aws_launch_template" "launchtemplate" {
  name_prefix   = "ansibleprojekt"
  image_id      = var.ami
  instance_type = "t2.micro"

}

resource "aws_autoscaling_group" "asg" {
  # availability_zones = ["us-east-1a"]
  vpc_zone_identifier = data.aws_vpcs.main_vpc.ids
  desired_capacity   = 1
  max_size           = 3
  min_size           = 1
  
# resource "aws_autoscaling_group" "example" {
#   capacity_rebalance  = true
#   desired_capacity    = 1
#   max_size            = 5
#   min_size            = 1
#   vpc_zone_identifier = [var.subnet.id]

  launch_template {
    id      = aws_launch_template.launchtemplate.id
    version = "$Latest"
  }
}

# # Create an AMI that will start a machine whose root device is backed by
# # an EBS volume populated from a snapshot. We assume that such a snapshot
# # already exists with the id "snap-xxxxxxxx".
# resource "aws_ami" "linux23" {
#   name                = "ansible-ec2"
#   virtualization_type = "hvm"
#   root_device_name    = "/dev/xvda"
#   imds_support        = "v2.0" # Enforce usage of IMDSv2. You can safely remove this line if your application explicitly doesn't support it.
#   ebs_block_device {
#     device_name = "/dev/xvda"
#     volume_size = 8
#   }
# }