resource "aws_s3_bucket" "tf_states_bucket" {
  bucket = var.bucket_name

  tags = {
    Environment = var.env
    Project     = var.project_name
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.tf_states_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "main" {
  bucket = aws_s3_bucket.tf_states_bucket.id
  policy = data.aws_iam_policy_document.main.json

  depends_on = [aws_s3_bucket_public_access_block.example]
}

data "aws_iam_policy_document" "main" {
  version = "2012-10-17"

  statement {
    sid = "AllowBucketAccess"
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = [
      aws_s3_bucket.tf_states_bucket.arn,
      "${aws_s3_bucket.tf_states_bucket.arn}/*"
    ]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}