resource "aws_ecr_repository" "dev" {
  name                 = "${var.name}-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  tags = var.additional_tags
}

resource "aws_ecr_lifecycle_policy" "policy" {
  repository = aws_ecr_repository.dev.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire images older than 14 days",
            "selection": {
                "tagStatus": "untagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 15
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}