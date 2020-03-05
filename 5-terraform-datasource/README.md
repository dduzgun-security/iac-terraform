# Datasource
#### Description
Datasources provides dynamic information that can always change

#### Example
```
data "aws_ip_ranges" "european_ec2" {
    region = ["eu-west-1". "eu-cetral-1"]
    services = ["ec2"]
}

resource "aws_security_group" "from_europe" {
    name = "from_europe"
    ingress {
        from_port = "443"
        to_port = "443"
        protocol = "tcp"
        cidr_blocks = ["${data.aws_ip_ranges.european_ec2.cidr_blocks}"]
    }
    tags {
        CreateDate = "${data.aws_ip_ranges.european_ec2.create_date}"
        SyncToken = "${data.aws_ip_ranges.european_ec2.sync_token}"
    }
}
```

#### Configuring
1. Add the backend to a .tf file
2. Run the init process


###### Exemple (consul)
```
terraform {
    "backend" "consul" {
        address = "demo.consul.io"
        path = "terraform/myproject"
    }
}
```

###### Exemple (s3)
```
terraform {
    "backend" "s3" {
        bucket = "mybucket"
        region = "eu-west-1"
        key = "terraform/myproject"
    }
}
```

We would need to configure aws locally before
```
aws configure 
> AWS key
> AWS secret key
> region
> output
```

#### Read from the state
```
data "terraform_remote_state" "aws-state" {
    backend = "s3"
    config {
        bucket = "terraform-state"
        key = "terraform.tfstate"
        access_key = "${var.AWS_ACCESS_KEY}"
        secret_key = "${var.AWS_SECRET_KEY}"
        region = "${var.AWS_REGION"
    }
}
```

#### Advantages of remote store
Ensure that we always have the latest version of the state
Avoid commit and push the terraform tfstate to version control

