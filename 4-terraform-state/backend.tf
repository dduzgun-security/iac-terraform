terraform {
    backend "s3" {
        bucket = "myexistingbucket"
        region = "eu-west-1"
        key = "terraform/myproject"
    }
}