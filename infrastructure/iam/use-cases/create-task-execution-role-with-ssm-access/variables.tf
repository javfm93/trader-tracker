variable "parameters" {
  type = list(object({ name = string, valueFrom = string }))
}
