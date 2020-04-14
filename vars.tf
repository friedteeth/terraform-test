variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
    default = "us-east-2"
}
variables "AMIS" {
    type = "map"
    default = {
        us-east-1 = "ami-07ebfd5b3428b6f4d"
        us-east-2 = "ami-0fc20dd1da406780b"
    }
}