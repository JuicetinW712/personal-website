resource "aws_s3_object" "files_to_upload" {
  for_each = local.files_to_upload

  bucket       = var.bucket_id
  key          = each.key
  source       = "${var.source_path}/${each.key}"
  content_type = each.value
  etag         = filemd5("${var.source_path}/${each.key}")
}