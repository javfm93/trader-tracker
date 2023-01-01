data "aws_iam_policy_document" "assume-ecs-tasks" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["ecs-tasks.amazonaws.com"]
      type        = "Service"
    }
  }
}

data "aws_iam_policy_document" "access-to-parameter-store" {
  statement {
    actions   = ["ssm:GetParameters"]
    effect    = "Allow"
    resources = [for parameter in var.parameters : parameter.valueFrom]
  }
}

