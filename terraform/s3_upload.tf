# resource "aws_s3_object" "files_to_upload" {
#   for_each = local.files_to_upload

#   bucket       = aws_s3_bucket.this.id
#   key          = each.key
#   source       = "${path.module}/app/${each.key}"
#   content_type = each.value
#   etag         = filemd5("${path.module}/app/${each.key}")

#   depends_on = [
#     aws_s3_bucket_policy.cloudfront_read_policy,
#     aws_s3_bucket_public_access_block.deny_public_access
#   ]
# }