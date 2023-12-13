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

resource "aws_launch_template" "ansibleprojekt" {
  name_prefix   = "ansibleprojekt"
  image_id      = var.ami
  instance_type = "t2.micro"
  vpc_security_group_ids = var.ec2_security_group_name.id
}

resource "aws_autoscaling_group" "bar" {
  availability_zones = ["us-east-1a"]
  desired_capacity   = 1
  max_size           = 3
  min_size           = 1

  launch_template {
    id      = aws_launch_template.ansibleprojekt.id
    version = "$Latest"
  }
}