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
###### Variables
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
The placeholders can be initialized inside the terraform.tfvars file.

``` 
AMIS = "..."
AWS_REGION = "..."
```

