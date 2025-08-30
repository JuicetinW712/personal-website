output "zone_id" {
  description = "The ID of the Route 53 zone"
  value       = aws_route53_zone.main.zone_id
}

output "validation_record_fqdns" {
  description = "List of FQDNs for ACM validation records"
  value       = [for record in aws_route53_record.acm_validation : record.fqdn]
}