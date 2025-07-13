locals {
  s3_origin_id = "${var.project_name}-origin"

  files_to_upload = merge(
    { for f in fileset("${path.module}/app/", "**/*.html") : f => "text/html" },
    { for f in fileset("${path.module}/app/", "**/*.css") : f => "text/css" },
    { for f in fileset("${path.module}/app/", "**/*.js") : f => "application/javascript" },
    { for f in fileset("${path.module}/app/", "**/*.ico") : f => "image/vnd.microsoft.icon" }
  )
}