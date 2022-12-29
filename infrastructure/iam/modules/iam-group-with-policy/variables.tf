variable "group_name" {
  description = "Name of IAM group"
  type        = string
}

variable "group_users" {
  description = "List of IAM users name to have in an IAM group which can assume the role"
  type        = list(string)
}

variable "group_policy_arn" {
  description = "Arn of the policy to attach to the group"
  type        = string
}
