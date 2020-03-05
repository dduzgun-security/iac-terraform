# Modules
#### Description
1. To make terraform more organized
2. Use third party modules (ex: github)
3. Reuse parts of you code (ex: VPC)



#### Using a third party module (ex: git)

```
module "module-example" {
    source = "github.com/wardviaene/terraform-module-example"
}
```

#### Using a module from a local folder
```
module "module-example" {
    source = "./module-example"
}
```

#### Passing arguments to a module
```
module "module-example" {
    source = "./module-example"
    region = "us-west-1"
    ip-range = "10.0.0.0/8"
    cluster-size = "3"
}
```

#### How to get/run a module
``` terraform get ```
It will create a modules folder under .terraform