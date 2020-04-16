provider "aws" {
    access_key = var.AWS_ACCESS_KEY
    secret_key = var.AWS_SECRET_KEY
    region = "us-east-2"
}

data "aws_availability_zones" "all" {}

resource "aws_security_group" "instance" {
    name = "terraform-example-instance"
    
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_launch_configuration" "config_webserver" {
    image_id = "ami-0fc20dd1da406780b"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.instance.id]

    user_data = file("scripts/web_server.sh")

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "grupo_webserver_scalable" {
    launch_configuration = aws_launch_configuration.config_webserver.id
    availability_zones = data.aws_availability_zones.all.names

    min_size = 2
    max_size = 10

    load_balancers = [aws_elb.elb_ejemplo.name]

    tag {
        key = "Name"
        value = "webserverelbc"
        propagate_at_launch = true
    }
}

resource "aws_security_group" "elb" {
    name = "sg_elb"

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_elb" "elb_ejemplo" {
    name = "webserverelbc"
    security_groups = [aws_security_group.elb.id]
    availability_zones = data.aws_availability_zones.all.names

    listener {
        lb_port = 80
        lb_protocol = "http"
        instance_port = 8080
        instance_protocol = "http"
    }
}

output "clb_nombre_dns" {
  value = aws_elb.elb_ejemplo.dns_name
  description = "Nombre de dominio del balanceador de carga"
}
