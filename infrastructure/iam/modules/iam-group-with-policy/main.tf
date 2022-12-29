resource "aws_iam_group" "this" {
  name = var.group_name
}

resource "aws_iam_policy_attachment" "this" {
  name       = "${var.group_name}-policy"
  groups     = [aws_iam_group.this.name]
  policy_arn = var.group_policy_arn
}


resource "aws_iam_group_membership" "this" {
  name  = "${var.group_name}-members"
  group = aws_iam_group.this.name
  users = var.group_users
}
