variable "ACCESS_KEY_HERE" {}
variable "SECRET_KEY_HERE" {}
variable "AWS_REGION" {
    type    = "string"
    default = "eu-west-1"
}
variable "AMIS" {
    type    = "map"
    default = {
        us-east-1 = "ami-13be557e"
        us-west-1 = "ami-06b94666"
        eu-west-1 = "ami-0d729a60"
    }
}