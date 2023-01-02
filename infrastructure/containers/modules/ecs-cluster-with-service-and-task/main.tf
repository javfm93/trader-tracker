# security:
#   execution_role: role used by tasks to pull docker images and inject secrets
#   task_role: role injected to the app to access other aws resources
#   service_role: service-linked role with to manage scaling, launch, destruction...

resource "aws_ecs_cluster" "this" {
  name = "${var.app_name}-ecs-cluster"
}

resource "aws_ecs_task_definition" "this" {
  execution_role_arn    = var.ecs_task_execution_role_arn
  container_definitions = local.container_definition
  family                = "${var.app_name}-task-definition"
}

resource "aws_ecs_service" "this" {
  name            = "${var.app_name}-ecs-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 2

  load_balancer {
    elb_name       = var.elb_name
    container_name = "${var.app_name}-ecs-container"
    container_port = var.app_port
  }
}

locals {
  container_definition = jsonencode([
    {
      essential : true,
      memory : 256,
      name : "${var.app_name}-ecs-container",
      cpu : 256,
      image : replace(var.ecr_repository_url, "https://", ""),
      workingDirectory : "/code",
      command : [
        "npm",
        "start"
      ],
      portMappings : [
        {
          "containerPort" : var.app_port,
          "hostPort" : var.app_port
        }
      ],
      logConfiguration = {
        logDriver = "awslogs"
        options   = {
          awslogs-group         = "${var.app_name}-logs"
          awslogs-region        = var.region
          awslogs-stream-prefix = var.app_name
        }
      }
      secrets : var.parameters
    }
  ])
}
