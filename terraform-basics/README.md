# What is Terraform
#### Description
Infrastructure as code
Automation of the infrastructure
Keep the infrastructure in a certain state for compliancy
Makes the infrastructure auditable
Keep changes history in verison control

#### Installation
Download terraform from to https://www.terraform.io/downloads.html
Add to path ``` export PATH=/c/terraform/:$PATH ```


#### HCL (HashiCorp Configuration Language)
###### Variables types
String
```
"Text"
```
Number
```
123
```
Bool
```
true/false
```
List(type)
```
[1,2,3,4]
```
Map(type)
```
{"key" = "value"}
```
Object({<ATTR NAME> = <TYPE>, ...})
```
{
    firstname = "Name"
    age = 20
}
```
Tuple([<TYPE>, ...])
```
[0, "text", false]
```

###### Variables example
```
variable "myvar" {
    type = "string"
    default = "Hello world"
}

variable "mymap" {
    type = map(string)
    default = {
        mykey = "my value"
    }
}

variable "mylist" {
    type = list
    default = [1,2,3]
}
```

###### Test in console
```
terraform console
> var.myvar
> "${var.myvar}"

> var.mymap["mykey"]
> "${var.mymap["mykey"]}"

> var.mylist[0]
> "${var.mylist[0]}"
> element(var.mylist, 0)
> slice(var.mylist, 0, 2)
```

###### Providers
```
provider "aws" {

}
```
To initilize the terraform provider, we need to run ```terraform init```.

Then, we can run ```terraform console```.

###### Resources
```
resource "aws_instance" "example" {
    ami           = var.AMIS[var.AWS_REGION]
    instance_type = "t2.micro"
}
```

###### terraform.tfvars
The placeholders values can be initialized inside the terraform.tfvars file.

``` 
AMIS = "..."
AWS_REGION = "..."
```

#### Set up AWS account
1. Create an AWS account
2. Create a new IAM user with the appropriate roles
3. Export the acces keys

#### First instance deployment with terraform
###### main (.tf)
``` 
provider "aws" {
  access_key = "ACCESS_KEY_HERE"
  secret_key = "SECRET_KEY_HERE"
  region     = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0d729a60"
  instance_type = "t2.micro"
}
```
###### versions (.tf)
``` 
terraform {
  required_version = ">= 0.12"
}
```

#### Terraform commands

###### initialize
```terraform init```

###### apply
```terraform apply```

###### destroy
```terraform destroy```

###### plan
To see all the commands that are planing to run
```terraform plan```

###### safe way
Save the changes to an out file, applying only the new changes to the infrastructure
```terraform plan -out out.terraform```

```terraform apply out.terraform```

```rm out.terraform```


#### Terraform example
###### provider (.tf)
```
provider "aws" {
  access_key = "${ACCESS_KEY_HERE}"
  secret_key = "${SECRET_KEY_HERE}"
  region     = "${AWS_REGION}"
}
```

###### instance (.tf)
```
resource "aws_instance" "example" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
}
```
###### vars (.tf)
```
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
```
###### terraform (.tfvars)
Always inside the .gitignore file
```
ACCESS_KEY_HERE = ""
SECRET_KEY_HERE = ""
```

