# security:
#   execution_role: role used by tasks to pull docker images and inject secrets
#   task_role: role injected to the app to access other aws resources
#   service_role: service-linked role with to manage scaling, launch, destruction...

resource "aws_ecs_cluster" "this" {
  name = "${var.app_name}-cluster"
}

// execution: pull img from ecr, take params, push to cloudwatch
// taskrole = access required by the app. queues...etc
resource "aws_ecs_task_definition" "this" {
  execution_role_arn    = var.ecs_task_execution_role_arn
  container_definitions = local.task-definition
  family                = var.app_name
}

resource "aws_ecs_service" "this" {
  name            = var.app_name
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 2
  #  I think i dont need this role as it is automatic
  #  iam_role        = var.ecs_iam_role_arn
  // necessary role to connect with the load balancer
  load_balancer {
    elb_name       = var.elb_name
    container_name = var.app_name
    container_port = var.app_port
  }
}

locals {
  task-definition = jsonencode([
    {
      essential : true,
      memory : 256,
      name : var.app_name,
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
