##creating an AWS SQS Queue
resource "aws_sqs_queue" "atom_wise_test" {
  name                      = "atom_wise_test_sqs"
  delay_seconds             = 0
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 0
  tags {
    Name = "atom_wise_test"
  }
}
