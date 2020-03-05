data "template_file" "my-template" {
    template = "${file("templates/init.tpl")}"

    vars {
        myip = "{aws_instance.database1.private_ip}"
    }
}

resource "aws_instance" "web" {
    user_data = "${data.template_file.my-template.rendered}"
}