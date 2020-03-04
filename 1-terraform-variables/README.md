# Variables
#### Description
Variables in terraform are used for multiple reason such as reusability, hidding secrets and ease of edit.

#### Types
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

#### Example
###### provider (.tf)
```
provider "aws" {
  access_key = "${var.ACCESS_KEY_HERE}"
  secret_key = "${var.SECRET_KEY_HERE}"
  region     = "${var.AWS_REGION}"
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
ACCESS_KEY_HERE = "..."
SECRET_KEY_HERE = "..."
```
