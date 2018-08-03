import boto3
import sys, os

client = boto3.client('sqs')

sqs_url = client.get_queue_url(
    QueueName='test',
)

def retrieve_sqs(client,sqs_url):
    try:
        response1 = client.receive_message(
        QueueUrl=sqs_url['QueueUrl'],
        MessageAttributeNames=[
            'string',
        ],        
        )
        command = response1['Messages'][0]['Body']
        print(response1)
        os.system(command)

        rec_handle = response1['Messages'][0]['ReceiptHandle']
        delete_message(client,sqs_url,rec_handle)

        retrieve_sqs(client,response)
    except:
        print("No Messages is SQS")

def delete_message(client,sqs_url,rec_handle):
    try:
        response = client.delete_message(
        QueueUrl=sqs_url['QueueUrl'],
        ReceiptHandle='string'
        )
    except:
        print("Deleted Messages")

if __name__ == "__main__":
    retrieve_sqs(client,sqs_url)
