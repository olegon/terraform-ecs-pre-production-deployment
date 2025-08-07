resource "aws_route53_zone" "private" {
  name = "olegon-private.com"

  vpc {
    vpc_id = data.aws_vpc.default.id
  }
}

resource "aws_route53_record" "elb_pre_production" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "*.elb-pre-production.olegon-private.com"
  type    = "A"

  alias {
    name                   = aws_lb.pre_production.dns_name
    zone_id                = aws_lb.pre_production.zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "elb_production" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "*.elb-production.olegon-private.com"
  type    = "A"

  alias {
    name                   = aws_lb.production.dns_name
    zone_id                = aws_lb.production.zone_id
    evaluate_target_health = false
  }
}