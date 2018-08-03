#Creates Launch configuration for ECS
resource "aws_launch_configuration" "ecs-launch-configuration" {
name = "ecs-launch-configuration"
image_id = "ami-644a431b"
instance_type = "t2.micro"
root_block_device {
volume_type = "standard"
volume_size = 100
delete_on_termination = true
}
lifecycle {
create_before_destroy = true
}
associate_public_ip_address = "true"
}

#Creates Auto Scaling Group
resource "aws_autoscaling_group" "ecs-autoscaling-group" {
name = "ecs-autoscaling-group"
max_size = "2"
min_size = "1"
desired_capacity = "1"
vpc_zone_identifier = ["${aws_subnet.atom_wise_test.id}"]
launch_configuration = "${aws_launch_configuration.ecs-launch-configuration.name}"
health_check_type = "ELB"
}

#Creates ECS Cluster
resource "aws_ecs_cluster" "atom_wise_test" {
name = "atom_wise_test"
}

##creating Task definitions for ECS
resource "aws_ecs_task_definition" "atom_wise_test_def" {
  family                = "atom_wise_test_service"
  container_definitions = "${file("task-definitions/service.json")}"

}

##creating ECS service
resource "aws_ecs_service" "atom_wise_test" {
  name            = "atom_wise_test"
  cluster         = "${aws_ecs_cluster.atom_wise_test.id}"
  task_definition = "${aws_ecs_task_definition.atom_wise_test_def.arn}"
  launch_type = "EC2"
  desired_count   = 1
}
