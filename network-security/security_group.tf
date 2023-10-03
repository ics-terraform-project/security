resource "aws_security_group" "sg-app" {
  name        = "app-sg"
  description = "Security Group app"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb-sg.id]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
    "0.0.0.0/0"]
  }

  tags = {
    Name        = format("%s-%s-app-sg", var.customer, var.environment)
    Environment = var.environment
  }
}