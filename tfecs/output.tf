output "elb" {
  value = "${aws_elb.qa-nginx-elb.dns_name}"
}

output "qa-nginx-repository-URL" {
value = "${data.aws_ecr_repository.qa-nginx.repository_url}"
}