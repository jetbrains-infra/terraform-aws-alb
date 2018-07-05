## About
Terraform module to run AWS ALB

Features: 
* A security group to allow incoming connection from Internet and outgoing connection to private subnets 

## Usage

```
module "loadbalancer" {
  source             = "github.com/jetbrains-infra/terraform-aws-alb"
  name               = "demo"
  target_cidr_blocks = ["${local.private_cidr_blocks}"]
  public_subnets     = ["${module.vpc.subnet_public_1}","${module.vpc.subnet_public_2}"]
  certificate_arn    = "${module.alb_certificate.arn}"
}
```

All params:
```
module "loadbalancer" {
  source             = "github.com/jetbrains-infra/terraform-aws-alb"
  name               = "demo"
  target_cidr_blocks = ["${local.private_cidr_blocks}"]
  https_ports        = [443]
  http_ports         = [80]
  public_subnets     = ["${module.vpc.subnet_public_1}","${module.vpc.subnet_public_2}"]
  certificate_arn    = "${module.alb_certificate.arn}"
}
```

**NB!** You need to allow the incoming traffic from ALB subnets to sources into a private subnet(s).

## Outputs

* `arn` - load balancer ARN