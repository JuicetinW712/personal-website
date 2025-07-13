resource "aws_s3_object" "html_files" {
  for_each = fileset("app/", "*.html")

  key          = each.value
  bucket       = aws_s3_bucket.this.id
  source       = "app/${each.value}"
  content_type = "text/html"
  etag         = filemd5("app/${each.value}")
  acl          = "public-read"
}

resource "aws_s3_object" "css_files" {
  for_each = fileset("app/", "*.css")

  key          = each.value
  bucket       = aws_s3_bucket.this.id
  source       = "app/${each.value}"
  content_type = "text/css"
  etag         = filemd5("app/${each.value}")
  acl          = "public-read"
}

resource "aws_s3_object" "js_files" {
  for_each = fileset("app/", "*.js")

  key          = each.value
  bucket       = aws_s3_bucket.this.id
  source       = "app/${each.value}"
  content_type = "application/javascript"
  etag         = filemd5("app/${each.value}")
  acl          = "public-read"
}