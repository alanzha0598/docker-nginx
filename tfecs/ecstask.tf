# app


data "template_file" "qa-nginx-task-definition-template" {
  template = "${file("templates/qa-nginx.json.tpl")}"
  vars {
    REPOSITORY_URL = "${data.aws_ecr_repository.qa-nginx.repository_url}"
    APP_VERSION = "${var.MYAPP_VERSION}"
   
  }
}

resource "aws_ecs_task_definition" "qa-nginx-def" {
  family                = "qa-nginx"
  container_definitions = "${data.template_file.qa-nginx-task-definition-template.rendered}"

}



resource "aws_ecs_service" "qa-nginx-service" {
  name = "qa-nginx"
  cluster = "${aws_ecs_cluster.BMO-cluster.id}"
  task_definition = "${aws_ecs_task_definition.qa-nginx-def.arn}"
  desired_count = 1
  iam_role = "${aws_iam_role.ecs-service-role.arn}"
  depends_on = ["aws_iam_policy_attachment.ecs-service-attach1"]

  load_balancer {
    elb_name = "${aws_elb.qa-nginx-elb.name}"
    container_name = "qa-nginx"
    container_port = 80
  }
  lifecycle { ignore_changes = ["task_definition"] }
}


resource "aws_elb" "qa-nginx-elb" {
  name = "qa-nginx-elb"

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  health_check {
    healthy_threshold = 3
    unhealthy_threshold = 3
    timeout = 30
    target = "HTTP:80/"
    interval = 60
  }

  cross_zone_load_balancing = true
  idle_timeout = 400
  connection_draining = true
  connection_draining_timeout = 400

  subnets = ["${aws_subnet.BMO-public-1.id}","${aws_subnet.BMO-public-2.id}"]
  security_groups = ["${aws_security_group.qa-nginx-elb-securitygroup.id}"]

  tags {
    Name = "BMO-qa-nginx-elb"
  }
}
