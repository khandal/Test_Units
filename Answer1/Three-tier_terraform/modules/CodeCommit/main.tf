resource "aws_codecommit_repository" "codecommit" {
  repository_name = "${var.name}-frontend"
  description     = "This is the india Frontend gitlab.kelltontech.net mirror Repository"

  tags = var.additional_tags
}