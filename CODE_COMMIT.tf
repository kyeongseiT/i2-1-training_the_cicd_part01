resource "aws_codecommit_repository" "REPOSITORY" {
  repository_name = "REPOSITORY"
  description     = "REPOSITORY"
  tags = {
    Name = format(
      "%s-%s-REPOSITORY",
      var.company,
      var.environment
     )
   }
}