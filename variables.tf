variable "name" {
  description = "Name of load balancer. Also used in security group name."
}

variable "public_subnets" {
  description = "List of AWS public subnet ids"
  type        = "list"
}

variable "target_cidr_blocks" {
  description = "List of AWS private target subnet CIDR"
  type        = "list"
}

variable "http_ports" {
  description = "List of plain http ports"
  type        = "list"
  default     = [80]
}

variable "https_ports" {
  description = "List of encrypted https ports"
  type        = "list"
  default     = [443]
}

variable "certificate_arn" {
  description = "Certificate for ALB that should contains "
  default     = ""
}

variable "access_log_bucket" {
  description = "Bucket to setore ALB access log"
  default     = ""
}

variable "access_log_prefix" {
  description = "Enable ALB access log"
  default     = ""
}

locals {
  all_ports       = ["${concat(var.https_ports, var.http_ports)}"]
}

data "aws_subnet" "public_1" {
  id = "${var.public_subnets[0]}"
}

locals {
  vpc_id = "${data.aws_subnet.public_1.vpc_id}"
}

// magic to get map of port to listener arn pairs
locals {
  listener_http_ports  = ["${aws_alb_listener.http.*.port}"]
  listener_http_arn    = ["${aws_alb_listener.http.*.arn}"]
  listener_https_ports = ["${aws_alb_listener.https.*.port}"]
  listener_https_arn   = ["${aws_alb_listener.https.*.arn}"]
}

locals {
  listener_http_map  = "${zipmap(local.listener_http_ports, local.listener_http_arn)}"
  listener_https_map = "${zipmap(local.listener_https_ports, local.listener_https_arn)}"
  listeners          = "${merge(local.listener_http_map, local.listener_https_map)}"
}

locals {
  access_logs_enable = "${var.access_log_bucket == "" ? false : true}"
  access_logs_bucket = "${var.access_log_bucket}"
  access_logs_prefix = "${var.access_log_prefix}"
}