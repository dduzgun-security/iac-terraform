# Provisioning
#### Description
Provisioning is used to configure/install softwares on the created infrastructure.

#### How
1. Building an own custom AMI and bundle the software with the image (Packer)
2. Boot standardized AMIs and install softwares on it by uploading files, remote exec or using automation tools such as chef, puppet, ansible, helm

#### File uploads
Easy way to upload a file that we might want to do a remote exec in the future. (ex. shell scripts)
###### Normal
```
resource "aws_instance" "example" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
}

provisiner "conf-file" {
    source = "app.conf"
    destination = "/etc/myapp.conf"
}
```

###### With SSH (username/password)
```
resource "aws_instance" "example" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
}

provisiner "file" {
    source = "script.sh"
    destination = "/opt/script.sh"
    connection {
        user     = "${var.instance_username}"
        password = "${var.instance_password}"
    }
}
```

###### With SSH keypair (username/private_key)
```
resource "aws_key_pair" "mykey" {
    key_name = "mykey"
    public_key = "ssh-rsa EnterThePublicKeyHere"
}

resource "aws_instance" "example" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.mykey.key_name}"
}

provisiner "file" {
    source = "script.sh"
    destination = "/opt/script.sh"
    connection {
        user     = "${var.instance_username}"
        password = "${file(${var.path_to_private_key})}"
    }
}
```

#### Remote exec
Used to execute commands
###### instance (.tf)
```
resource "aws_instance" "example" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
}

provisiner "file" {
    source = "script.sh"
    destination = "/opt/script.sh"
}

provisiner "remote-exec" {
    inline = [
        "chmod +x /opt/script.sh",
        "/opt/script.sh arguments"
    ]
}
```

#### Security group
We must add our public ip in the security groups for TCP trafics in order to acces SSH ports with the ssh keys.
