# Outputs
#### Description
Terraform keeps attributes of all created resources to be queried or outputed

Usefull to output the valuable information to feed information to external software

#### Types


#### Example

###### Output
```
resource "aws_instance" "example" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
}

output "ip" {
    value = "${aws_instance.example.public_ip}"
}
```

###### Output locally
```
resource "aws_instance" "example" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  provisioner "local-exec" {
      command = "echo ${aws_instance.example.private_ip}" >> private_ips.txt
  }
}
```

