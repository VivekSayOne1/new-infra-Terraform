output "iam-user" {
  
  value = aws_iam_user.iam-user.id
}
output "password" {
  value = aws_iam_user_login_profile.password-iam.encrypted_password
}
output "terraform_role" {
  value = aws_iam_instance_profile.terraform_profile.name
}
output "lambda_role" {
  value = aws_iam_role.terraform_lambda.arn
}
output "iam-role" {
  value = aws_iam_role.terraform_role.arn
}