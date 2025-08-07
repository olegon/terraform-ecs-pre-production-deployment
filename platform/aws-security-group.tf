resource "aws_security_group" "production_reverse_proxy" {
  name        = "production-reverse-proxy"
  description = "Allows ELB production-reverse-proxy traffic."
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description      = "http (prod)"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "http (test)"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group" "pre_production" {
  name        = "pre-production"
  description = "Allows ELB pre-production traffic."
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "any"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = data.aws_vpc.default.cidr_block_associations[*].cidr_block
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group" "production" {
  name        = "production"
  description = "Allows ELB production traffic."
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "any"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = data.aws_vpc.default.cidr_block_associations[*].cidr_block
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}