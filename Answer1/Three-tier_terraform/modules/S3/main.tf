resource "aws_s3_bucket" "backend-bucket" {
  bucket = "${var.name}-backend-bucket"
  tags   = var.additional_tags
}
resource "aws_s3_bucket_versioning" "bucket_version" {
  bucket = aws_s3_bucket.backend-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}


# resource "aws_s3_bucket_policy" "backend-bucket-policy" {
#   bucket = aws_s3_bucket.backend-bucket.id
#   policy = <<EOF
#     {
#     "Version": "2012-10-17",
#     "Id": "AWSConsole-AccessLogs-Policy-paybackdev-backend-bucket-cloudinary",
#     "Statement": [
#         {
#             "Sid": "AWSConsoleStmt-paybackdev-backend-bucket-cloudinary",
#             "Effect": "Allow",
#             "Principal": {
#                 "AWS": "arn:aws:iam::232482882421:root"
#             },
#             "Action": [
#                 "s3:GetObject",
#                 "s3:PutObject",
#                 "s3:PutObjectAcl",
#                 "s3:List*"
#             ],
#             "Resource": "arn:aws:s3:::${var.name}-backend-bucket/*"
#             }
#           ]
#     }
#   EOF
# }


resource "aws_s3_bucket_server_side_encryption_configuration" "backend-bucket" {
  bucket = aws_s3_bucket.backend-bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
resource "aws_s3_bucket_ownership_controls" "backend-bucket" {
  bucket = aws_s3_bucket.backend-bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}


resource "aws_s3_bucket_public_access_block" "backend-bucket" {
  bucket                  = aws_s3_bucket.backend-bucket.id
  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

