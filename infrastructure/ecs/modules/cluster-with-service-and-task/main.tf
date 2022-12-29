resource "aws_ecs_cluster" "this" {
  name = "${var.app_name}-cluster"
}

resource "aws_ecs_task_definition" "this" {
  container_definitions = templatefile("${path.module}/task_definition.json.tftpl", {
    repository_url = replace(var.ecr_repository_url, "https://", "")
    app_name       = var.app_name
    app_port       = var.app_port
    region         = var.region
  })
  family = var.app_name
}

resource "aws_ecs_service" "this" {
  name            = var.app_name
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 2
  iam_role        = var.ecs_iam_role_arn

  load_balancer {
    elb_name       = var.elb_name
    container_name = var.app_name
    container_port = var.app_port
  }
}


