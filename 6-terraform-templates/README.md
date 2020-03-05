# Templates
#### Description
Template provider help creating customized configuration files

Templates can be build based on variables from terraform resource attributes

#### Template file (templates/init.tpl)
```
#!/bin/bash
echo "dtabase-ip = ${myip}" >> /etc/myapp.config
```

#### Template resource
```
data "template_file" "my-template" {
    template = "${file("templates/init.tpl")}"

    vars {
        myip = "{aws_instance.database1.private_ip}"
    }
}
```

#### Calling the data
```
resource "aws_instance" "web" {
    user_data = "${data.template_file.my-template.rendered}"
}
```
