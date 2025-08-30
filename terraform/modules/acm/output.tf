output "certificate_arn" {
  description = "The ARN of the ACM certificate"
  value       = aws_acm_certificate.this.arn
}

output "certificate_validation_arn" {
  description = "The ARN of the certificate validation"
  value       = aws_acm_certificate_validation.cert_validation.certificate_arn
}