resource "aws_elb" "this" {
  name = "${var.app_name}-elb"
  listener {
    instance_port     = var.app_port
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold   = 3
    interval            = 60
    target              = "HTTP:${var.app_port}/"
    timeout             = 30
    unhealthy_threshold = 3
  }
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  subnets         = var.public_subnets_id
  security_groups = [var.security_group_id]
  tags            = {
    Name = "${var.app_name}-elb"
  }
}
