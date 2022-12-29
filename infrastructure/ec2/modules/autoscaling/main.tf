resource "aws_launch_configuration" "this" {
  name                 = "${var.app_name}-launch_config"
  image_id             = var.ami
  instance_type        = var.instance_type
  key_name             = var.key_pair_name
  iam_instance_profile = var.iam_instance_profile_id
  security_groups      = var.security_groups_id
  user_data            = "#!/bin/bash\necho 'ECS_CLUSTER=${var.app_name}-cluster' > /etc/ecs/ecs.config\nstart ecs"
  lifecycle { create_before_destroy = true }
}

resource "aws_autoscaling_group" "this" {
  name                = "${var.app_name}-autoscaling"
  vpc_zone_identifier = var.public_subnets_id

  launch_configuration = aws_launch_configuration.this.name
  max_size             = 2
  min_size             = 1
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "${var.app_name}-autoscaling"
  }
}
