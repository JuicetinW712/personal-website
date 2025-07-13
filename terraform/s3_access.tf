# Disables all public access restrictions on bucket policies
resource "aws_s3_public_access_block" "allow_public_access" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = false
}

# Define permissions
data "aws_iam_policy_document" "read_access" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      aws_s3_bucket.this.arn,
      "${aws_s3_bucket.this.arn}/*"
    ]
  }
}

resource "aws_s3_bucket_policy" "public_read_policy" {
  bucket = aws_s3_bucket.public_read_bucket.id
  policy = data.aws_iam_policy_document.read_access.json

  depends_on = [aws_s3_public_access_block.allow_public_access]
}