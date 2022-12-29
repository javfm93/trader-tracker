resource "aws_cloudwatch_log_group" "cluster" {
  name = "${var.app_name}-logs"
}
