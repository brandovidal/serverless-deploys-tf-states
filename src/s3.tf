resource "aws_s3_bucket" "tf_states_bucket" {
  bucket = var.bucket_name

  tags = {
    Project = var.project_name
  }
}

resource "aws_s3_bucket_public_access_block" "default" {
  bucket = aws_s3_bucket.tf_states_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "policy_allow_s3" {
  bucket = aws_s3_bucket.tf_states_bucket.id
  policy = data.aws_iam_policy_document.combined.json

  depends_on = [aws_s3_bucket_public_access_block.default]
}

data "aws_iam_policy_document" "allow_s3" {
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

data "aws_iam_policy_document" "enforce_tls" {
  version = "2012-10-17"

  statement {
    sid    = "EnforceTLSv12orHigher"
    effect = "Deny"
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
    condition {
      test     = "NumericLessThan"
      variable = "s3:TlsVersion"
      values   = ["1.2"]
    }
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

data "aws_iam_policy_document" "combined" {
  source_policy_documents = [data.aws_iam_policy_document.allow_s3.json, data.aws_iam_policy_document.enforce_tls.json]
}

resource "aws_s3_bucket_versioning" "versioning_enabled" {
  bucket = aws_s3_bucket.tf_states_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
