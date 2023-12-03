resource "aws_security_group" "default_group" {
  name        = "${var.environment}-default-sg"
  description = "Default security group for main VPC Network"
  vpc_id      = aws_vpc.main_vpc.id
  depends_on = [
    aws_vpc.main_vpc
  ]

  tags = {
    "Name" = "${var.environment}-default-sg"
  }

}