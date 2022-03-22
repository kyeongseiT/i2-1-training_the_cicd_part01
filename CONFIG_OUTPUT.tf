
############################
output "AWS_ACCOUNT_ID" {
  value = data.aws_caller_identity.current.account_id
}

output "WEB_LB_DNS" {
    value = aws_lb.WEB_LB.dns_name
}

output "REPOSITORY_clone_url_ssh" {
    value = aws_codecommit_repository.REPOSITORY.clone_url_ssh
}
output "CODE_DEPLOY_ROLE_ARN" {
    value = aws_iam_role.CODE_DEPLOY_ROLE.arn
}

