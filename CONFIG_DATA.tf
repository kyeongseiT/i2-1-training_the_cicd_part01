data "aws_ami" "amazon-linux-2" {
 most_recent = true
 owners = ["137112412989"]
 filter {
   name   = "owner-alias"
   values = ["amazon"]
 }
 filter {
   name   = "name"
   values = ["amzn2-ami-hvm*"]
 }
}

resource "random_id" "random" {
    byte_length = 4
}
data "template_file" "web_server" {
  template = file("./script/WEB_SERVER_init.sh")
}

data "aws_caller_identity" "current" {}


