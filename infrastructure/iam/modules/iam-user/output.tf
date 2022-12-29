output "user_name" {
  value = aws_iam_user.this.name
}

output "administrator_login_name" {
  value = aws_iam_user_login_profile.this.user
}

output "administrator_login_password" {
  value = aws_iam_user_login_profile.this.password
}

output "administrator_access_key" {
  value = aws_iam_access_key.this.id
}

# todo: who can i show this? probably with a personal key when creating
output "administrator_secret" {
  value     = aws_iam_access_key.this.secret
  sensitive = true
}

