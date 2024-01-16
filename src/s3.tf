resource "aws_s3_bucket" "tf_states_bucket" {
  bucket = var.bucket_name

  tags = {
    Project = var.project_name
  }
}

resource "aws_s3_bucket_public_access_block" "default" {
  bucket = aws_s3_bucket.tf_states_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "main" {
  bucket = aws_s3_bucket.tf_states_bucket.id
  policy = data.aws_iam_policy_document.main.json

  depends_on = [aws_s3_bucket_public_access_block.default]
}

data "aws_iam_policy_document" "main" {
  version = "2012-10-17"

  statement {
    sid    = "AllowBucketAccess"
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

resource "aws_s3_bucket_versioning" "versioning_enabled" {
  bucket = aws_s3_bucket.tf_states_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}