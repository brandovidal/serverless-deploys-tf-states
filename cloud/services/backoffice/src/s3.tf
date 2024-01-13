# locals {
#   s3_bootstrap_filepath = "../app"
# }

# resource "aws_s3_bucket" "example_bucket" {
#   bucket = var.bucket_name

#   tags = {
#     Environment = "Dev"
#     Project     = "Codely course"
#   }
# }

# data "archive_file" "app" {
#   type        = "zip"
#   source_dir  = "app"
#   output_path = "build.zip"
# }

# resource "aws_s3_object" "object" {
#   bucket = aws_s3_bucket.example_bucket.id
#   key    = "build.zip"
#   source = data.archive_file.app.output_path
#   etag = filemd5(data.archive_file.app.output_path)
# }

# resource "aws_s3_bucket_public_access_block" "example" {
#   bucket = aws_s3_bucket.example_bucket.id

#   block_public_acls       = false
#   block_public_policy     = false
#   ignore_public_acls      = false
#   restrict_public_buckets = false
# }

# resource "aws_s3_bucket_policy" "main" {
#   bucket = aws_s3_bucket.example_bucket.id
#   policy = data.aws_iam_policy_document.main.json

#   depends_on = [aws_s3_bucket_public_access_block.example]
# }

# data "aws_iam_policy_document" "main" {
#   version = "2012-10-17"

#   statement {
#     sid = "AllowBucketAccess"

#     effect = "Allow"

#     actions = [
#       "s3:GetObject",
#       "s3:ListBucket",
#     ]
#     resources = [
#       aws_s3_bucket.example_bucket.arn,
#       "${aws_s3_bucket.example_bucket.arn}/*"
#     ]
#     principals {
#       type        = "AWS"
#       identifiers = ["*"]
#     }
#   }
# }

# # // get arn from lambda tfstate
# # data "terraform_remote_state" "remote_lambda" {
# #   backend = "s3"
# #   config = {
# #     bucket = "codely-tf-states"
# #     key    = "dev/services/catalog/compute/lambda/terraform.tfstate"
# #     region = "us-east-1"
# #   }
# # }

# # // S3 notification to lambda
# # resource "aws_s3_bucket_notification" "bucket_notification" {
# #   bucket = aws_s3_bucket.example_bucket.id

# #   lambda_function {
# #     lambda_function_arn = data.terraform_remote_state.remote_lambda.outputs.lambda_arn
# #     events              = ["s3:ObjectCreated:*"]
# #     filter_suffix       = ".png"
# #   }
# # }