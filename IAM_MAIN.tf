resource "aws_iam_user" "CODE_COMMIT_IAM" {
  name = format(
      "%s-%s-DEVELOPER",
      var.company,
      var.environment
     )
  path = "/"

}


resource "aws_iam_user_policy" "CODE_COMMIT_POLICY" {
  user = aws_iam_user.CODE_COMMIT_IAM.name
  name        = format(
      "%s-%s-CODE_COMMIT_POLICY",
      var.company,
      var.environment
     )
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "codecommit:*"
            ],
            "Resource": "arn:aws:codecommit:${var.region}:${data.aws_caller_identity.current.account_id}:REPOSITORY"
        },
        {
            "Sid": "IAMReadOnlyListAccess",
            "Effect": "Allow",
            "Action": [
                "iam:ListUsers"
            ],
            "Resource": "*"
        },
        {
            "Sid": "IAMReadOnlyConsoleAccess",
            "Effect": "Allow",
            "Action": [
                "iam:ListAccessKeys",
                "iam:ListSSHPublicKeys",
                "iam:ListServiceSpecificCredentials"
            ],
            "Resource": "arn:aws:iam::*:user/$${aws:username}"
        },
        {
            "Sid": "IAMUserSSHKeys",
            "Effect": "Allow",
            "Action": [
                "iam:DeleteSSHPublicKey",
                "iam:GetSSHPublicKey",
                "iam:ListSSHPublicKeys",
                "iam:UpdateSSHPublicKey",
                "iam:UploadSSHPublicKey"
            ],
            "Resource": "arn:aws:iam::*:user/$${aws:username}"
        },
        {
            "Sid": "IAMSelfManageServiceSpecificCredentials",
            "Effect": "Allow",
            "Action": [
                "iam:CreateServiceSpecificCredential",
                "iam:UpdateServiceSpecificCredential",
                "iam:DeleteServiceSpecificCredential",
                "iam:ResetServiceSpecificCredential"
            ],
            "Resource": "arn:aws:iam::*:user/$${aws:username}"
        }
    ]
})
}


