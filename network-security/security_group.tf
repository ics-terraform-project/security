resource "aws_security_group" "sg-app" {
  name        = "app-sg"
  description = "Security Group app"
  vpc_id      = "vpc-0916d84df8a768429"

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["sg-0f6a902391b8aeeda"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
    "0.0.0.0/0"]
  }

  tags = {
    Name        = format("%s-%s-app-sg", var.project, var.environment)
    Environment = var.environment
  }
}