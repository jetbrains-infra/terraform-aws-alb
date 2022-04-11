## About
Terraform module to run AWS ALB

Features: 
* A security group to allow incoming connection from Internet and outgoing connection to private subnets 

## Usage

```hcl
module "loadbalancer" {
  source             = "github.com/jetbrains-infra/terraform-aws-alb?ref=vX.X.X" // see https://github.com/jetbrains-infra/terraform-aws-alb/releases
  name               = "demo"
  target_cidr_blocks = [local.private_cidr_blocks]
  public_subnets     = [module.vpc.subnet_public_1, module.vpc.subnet_public_2]
  certificate_arn    = module.alb_certificate.arn
}
```

All params:
```hcl
module "loadbalancer" {
  source             = "github.com/jetbrains-infra/terraform-aws-alb?ref=vX.X.X" // see https://github.com/jetbrains-infra/terraform-aws-alb/releases
  name               = "demo"
  internal           = false
  target_cidr_blocks = [local.private_cidr_blocks]
  https_ports        = [443]
  http_ports         = [80]
  public_subnets     = [module.vpc.subnet_public_1, module.vpc.subnet_public_2]
  certificate_arn    = module.alb_certificate.arn // see https://github.com/jetbrains-infra/terraform-aws-acm-certificate
  access_log_bucket  = module.s3_logs.bucket_id // see https://github.com/jetbrains-infra/terraform-aws-s3-bucket-for-logs
  access_log_prefix  = module.s3_logs.alb_logs_path
  tags = {
    Name   = "FooBar",
    Module = "ECS Cluster"
  }
}
```

**NB!** You need to allow the incoming traffic from ALB subnets to targets into a private subnet(s).

## Outputs

* `arn` - load balancer ARN
* `dns_name` - ALB domain name
* `dns_zone_id` - ALB domain zone id