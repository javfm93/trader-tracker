output "iam-group-created" {
  value = "${var.group_name}: ${aws_iam_group.this.arn}"
}


output "iam-group_users-added" {
  value = flatten(aws_iam_group_membership.this[*].users)
}
