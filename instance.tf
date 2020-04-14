resource "aws_instance" "ejemplo" {
    ami = "$(lookup(var.AMIS, var.AWS_REGION))"
    instance_type = "t2.micro"
}
