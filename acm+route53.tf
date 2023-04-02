resource "aws_route53_zone" "primary" {

  name = var.domain_name

}

# resource "aws_route53_record" "route53-record" {
#   zone_id = aws_route53_zone.primary.zone_id
#   name    = "www"
#   type    = "A"
#   alias {
#     name                   = aws_lb.my-alb.dns_name
#     zone_id                = aws_lb.my-alb.zone_id
#     evaluate_target_health = true
#   }
# }

# resource "aws_route53_record" "cert_validation" {
#   allow_overwrite = true
#   name            = tolist(aws_acm_certificate.acm_certificate.domain_validation_options)[0].resource_record_name
#   records         = [ tolist(aws_acm_certificate.acm_certificate.domain_validation_options)[0].resource_record_value ]
#   type            = tolist(aws_acm_certificate.acm_certificate.domain_validation_options)[0].resource_record_type
#   zone_id  = aws_route53_zone.primary.id
#   ttl      = 60
# }

output "dns-name" {

  value = aws_route53_zone.primary.name

}


############# Aws Certificate Managar #############


resource "aws_acm_certificate" "acm_certificate" {
  domain_name       = var.domain_name
  validation_method = "DNS"

}

# resource "aws_acm_certificate_validation" "cert" {
#   certificate_arn         = aws_acm_certificate.acm_certificate.arn
#   validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]

# }









