resource "aws_elb" "main" {
  name = "example-lb"
  availability_zones = ["us-east-1a"]

  listener {
    instance_port = 80
    instance_protocol = "HTTP"
    lb_port = 80
    lb_protocol = "HTTP"
  }

  health_check {
    target = "HTTP:80/"
    interval = 30
    timeout = 5
    healthy_threshold = 2
    unhealthy_threshold = 2
  }

  instances = var.instance_ids
  security_groups = [var.lb_security_group_id]
}

output "lb_dns_name" {
  value = aws_elb.main.dns_name
}
