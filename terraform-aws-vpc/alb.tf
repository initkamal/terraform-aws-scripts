# Application load balancer

# Basic Configuration

resource "aws_alb" "alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  subnets            = aws_subnet.public.*.id

  tags = {
    Name = var.alb_name
  }
}

# Listeners

resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = aws_alb.alb.arn

  port     = 80
  protocol = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn

  }
}

# Target groups

resource "aws_lb_target_group" "alb_tg" {
  name     = "${var.alb_name}_tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id



  # Health Check

  health_check {
    healthy_threshold   = 2
    interval            = 30
    protocol            = "HTTP"
    unhealthy_threshold = 2
  }

  depends_on = [
    aws_alb.alb
  ]

}
