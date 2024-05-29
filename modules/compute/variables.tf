variable "region" {
  description = "The AWS region to deploy resources in"
}

variable "instance_type" {
  description = "The type of the EC2 instance"
}

variable "instance_count" {
  description = "Number of EC2 instances"
  default = 3
}

variable "subnet_id" {
  description = "ID of the subnet for EC2 instances"
}

variable "security_group_id" {
  description = "ID of the security group for EC2 instances"
}
