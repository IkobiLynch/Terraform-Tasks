resource "aws_launch_template" "main" {
  name_prefix = "example-lt"
  image_id = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y apache2
              sudo systemctl start apache2
              echo "<html><h1>Server $(hostname)</h1><html>"
              EOF

  network_interfaces {
    associate_public_ip_address = true
    security_groups = [var.security_group_id]
  }
}

resource "aws_autoscaling_group" "main" {
  desired_capacity = var.instance_count
  max_size = var.instance_count
  min_size = var.instance_count
  vpc_zone_identifier = [var.subnet_id]
  launch_template {
    id = aws_launch_template.main.id
    version = "$Latest"
  }
  health_check_type = "ELB"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["099720109477"]

  filter {
    name = "name"
    values = ["ubuntu/imagesvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

output "instance_ids" {
  value = aws_autoscaling_group.main.instances
}
