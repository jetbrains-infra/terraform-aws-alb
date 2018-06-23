## About
Terraform module to up AWS ALB

Features: 
* Security group to allow incoming connection from Internet and outgoing connection to private subnets 

## Usage

```
module "loadbalancer" {
  source                   = "github.com/jetbrains-infra/terraform-aws-alb"
  name                     = "alfa" // required
  public_subnets           = "${aws_subnet.public_1.id},${aws_subnet.public_2.id}" // required two subnets in different az
  private_subnets          = "${aws_subnet.private_1.id},${aws_subnet.private_2.id}" // required one at least 
  default_target_group_arn = "${aws_alb_target_group.default.arn}"
  http_ports               = [80]
  https_ports              = [443]
  certificate_arn          = "${aws_acm_certificate.default.arn}" //required if https_ports is not empty
  routs                    = [
    "example.net:80 -> ${aws_alb_target_group.main.arn}",
    "example.net:443 -> ${aws_alb_target_group.main.arn}",
    "*.example.net:443 -> ${aws_alb_target_group.main.arn}",
    "example.com:443 -> ${aws_alb_target_group.main.arn}"
  ]
}
```

**NB!** You need allow incoming traffic from ALB subnets to sources into private subnet(s).

## Outputs

* `arn` - load balancer ARN
* `ports` - listen ports