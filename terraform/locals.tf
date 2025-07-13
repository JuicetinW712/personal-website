locals {
  s3_origin_id   = "${var.project_name}-origin"
  s3_domain_name = "${var.project_name}.s3-website-${var.region}.amazonaws.com"
}