variable "region" {
  description = "The AWS region to deploy resources in"
}

variable "instance_ids" {
  description = "List of EC2 instance IDs"
}

variable "lb_security_group_id" {
  description = "ID of the security group for the load balancer"
}
