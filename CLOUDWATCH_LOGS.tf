resource "aws_cloudwatch_log_group" "CodeBuild" {
  name = format(
      "%s-%s-CODE_BUILD_LOGS",
      var.company,
      var.environment
     )
  retention_in_days = "1" 
  tags = {
    Environment = "production"
    Application = "serviceA"
  }
}