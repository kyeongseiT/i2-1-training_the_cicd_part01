resource "aws_iam_role_policy" "CODE_DEPLOY_ROLE" {
  name = format(
      "%s-%s-CODE_DEPLOY_ROLE",
      var.company,
      var.environment
     )
  role = aws_iam_role.CODE_DEPLOY_ROLE.id
  policy = <<-EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    "autoscaling:CompleteLifecycleAction",
                    "autoscaling:DeleteLifecycleHook",
                    "autoscaling:DescribeAutoScalingGroups",
                    "autoscaling:DescribeLifecycleHooks",
                    "autoscaling:PutLifecycleHook",
                    "autoscaling:RecordLifecycleActionHeartbeat",
                    "autoscaling:CreateAutoScalingGroup",
                    "autoscaling:UpdateAutoScalingGroup",
                    "autoscaling:EnableMetricsCollection",
                    "autoscaling:DescribeAutoScalingGroups",
                    "autoscaling:DescribePolicies",
                    "autoscaling:DescribeScheduledActions",
                    "autoscaling:DescribeNotificationConfigurations",
                    "autoscaling:DescribeLifecycleHooks",
                    "autoscaling:SuspendProcesses",
                    "autoscaling:ResumeProcesses",
                    "autoscaling:AttachLoadBalancers",
                    "autoscaling:AttachLoadBalancerTargetGroups",
                    "autoscaling:PutScalingPolicy",
                    "autoscaling:PutScheduledUpdateGroupAction",
                    "autoscaling:PutNotificationConfiguration",
                    "autoscaling:PutLifecycleHook",
                    "autoscaling:DescribeScalingActivities",
                    "autoscaling:DeleteAutoScalingGroup",
                    "ec2:DescribeInstances",
                    "ec2:DescribeInstanceStatus",
                    "ec2:TerminateInstances",
                    "tag:GetResources",
                    "sns:Publish",
                    "cloudwatch:DescribeAlarms",
                    "cloudwatch:PutMetricAlarm",
                    "elasticloadbalancing:DescribeLoadBalancers",
                    "elasticloadbalancing:DescribeInstanceHealth",
                    "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
                    "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
                    "elasticloadbalancing:DescribeTargetGroups",
                    "elasticloadbalancing:DescribeTargetHealth",
                    "elasticloadbalancing:RegisterTargets",
                    "elasticloadbalancing:DeregisterTargets",
                    "iam:PassRole",
                    "ec2:CreateTags",
                    "ec2:RunInstances",
                    "ecs:DescribeServices",
                    "ecs:CreateTaskSet",
                    "ecs:UpdateServicePrimaryTaskSet",
                    "ecs:DeleteTaskSet",
                    "elasticloadbalancing:DescribeListeners",
                    "elasticloadbalancing:ModifyListener",
                    "elasticloadbalancing:DescribeRules",
                    "elasticloadbalancing:ModifyRule",
                    "lambda:InvokeFunction",
                    "cloudwatch:DescribeAlarms",
                    "s3:GetObject",
                    "s3:GetObjectVersion"
                ],
                "Resource": "*"
            }
        ]
    }
  EOF
}
resource "aws_iam_role" "CODE_DEPLOY_ROLE" {
  name = format(
      "%s-%s-CODE_DEPLOY_ROLE",
      var.company,
      var.environment
     )

  assume_role_policy = <<-EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "codedeploy.amazonaws.com"
                ]
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
  EOF
}

