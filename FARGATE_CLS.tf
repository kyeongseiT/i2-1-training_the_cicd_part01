resource "aws_ecs_cluster" "cluster" {
  name = format(
      "%s-%s-CLUSTER",
      var.company,
      var.environment
     )

  capacity_providers = ["FARGATE_SPOT", "FARGATE"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
  }

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}
