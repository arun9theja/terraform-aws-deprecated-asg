# this output will also be used as variable, to have 'copy previous ASG capacity' capability, i.e.:
# before doing `terraform apply`, do `terraform refresh` and write `terraform output` output to <my-file>
# then do terraform apply -var-file='<my-file>'
output "asg-desired-capacity" {
  value = "${aws_autoscaling_group.app.desired_capacity}"
}
