output "elb_reverse_proxy_dns_name" {
  value = aws_lb.production_reverse_proxy.dns_name
}

output "elb_pre_production_dns_name" {
  value = aws_lb.pre_production.dns_name
}
