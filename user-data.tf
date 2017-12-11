data "template_file" "init" {
  template = "${file("${path.module}/cloud-init.tpl")}"
  vars {
      traveloka-env = "${var.traveloka-env}"
  }
}

# https://github.com/terraform-providers/terraform-provider-aws/issues/183
data "template_cloudinit_config" "config" {
    gzip          = false
    base64_encode = false

    part {
        content_type = "text/cloud-config"
        content      = "${data.template_file.init.rendered}"
    }
}
