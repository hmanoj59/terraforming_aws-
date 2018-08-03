import boto3
import sys, os

commands_list = ["ls", "mkdir atom_wise_test", "service apache2 start", ]

client = boto3.client('sqs')
sqs_url = client.get_queue_url(
    QueueName='atom_wise_test_sqs',
)

def create_sqs_mes(sqs_url,command):
    response = client.send_message(
        QueueUrl=sqs_url['QueueUrl'],
        MessageBody=command,
        DelaySeconds=0,
    )

for command in commands_list:
    create_sqs_mes(sqs_url,command)
