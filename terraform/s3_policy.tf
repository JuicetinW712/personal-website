# Disables public access to s3
resource "aws_s3_bucket_public_access_block" "deny_public_access" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Define permissions
data "aws_iam_policy_document" "read_access" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      aws_s3_bucket.this.arn,
      "${aws_s3_bucket.this.arn}/*"
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = [aws_cloudfront_distribution.s3.arn]
    }
  }
}

resource "aws_s3_bucket_policy" "cloudfront_read_policy" {
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.read_access.json

  depends_on = [aws_s3_bucket_public_access_block.deny_public_access]
}