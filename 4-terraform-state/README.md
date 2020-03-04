# States
#### Description
Terraform keeps the remote state of the infrastructure in terraform.tfstate after each apply
There is also a backup of the previous state in terraform.tfstate.backup after each apply



#### Saving the state
Saving states helps to collaborate and offers a way to not store sensitive information locally

1. The state file can be stored in a verison control such a git (possible conflicts)
2. The state file can be saved remote using backend functionalities in terraform inside local, s3 (with locking mechanism using dynamoDB), consul (with locking) or terraform enterprise.
3. Enhanced backends are possible also

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

