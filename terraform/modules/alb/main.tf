resource "aws_lb" "main" {
  name               = var.name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnet_ids
  
  enable_deletion_protection = var.enable_deletion_protection
  
  tags = {
    Name = var.name
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type = "redirect"
    
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.main.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = var.certificate_arn
  
  default_action {
    type = "fixed-response"
    
    fixed_response {
      content_type = "text/plain"
      message_body = "Service unavailable"
      status_code  = "503"
    }
  }
}

resource "aws_lb_target_group" "main" {
  count       = length(var.target_groups)
  name        = "${var.name}-tg-${count.index}"
  port        = var.target_groups[count.index].port
  protocol    = var.target_groups[count.index].protocol
  target_type = var.target_groups[count.index].target_type
  vpc_id      = var.vpc_id
  
  health_check {
    path                = var.target_groups[count.index].health_check_path
    port                = var.target_groups[count.index].health_check_port
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    matcher             = "200-299"
  }
  
  tags = {
    Name = "${var.name}-tg-${count.index}"
  }
}

resource "aws_lb_listener_rule" "main" {
  count        = length(var.listener_rules)
  listener_arn = aws_lb_listener.https.arn
  priority     = 100 + count.index
  
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main[var.listener_rules[count.index].target_group_index].arn
  }
  
  dynamic "condition" {
    for_each = var.listener_rules[count.index].host_header != null ? [1] : []
    content {
      host_header {
        values = [var.listener_rules[count.index].host_header]
      }
    }
  }
  
  dynamic "condition" {
    for_each = var.listener_rules[count.index].path_pattern != null ? [1] : []
    content {
      path_pattern {
        values = [var.listener_rules[count.index].path_pattern]
      }
    }
  }
}