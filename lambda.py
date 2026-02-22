import boto3
import os
import json

dynamodb = boto3.resource('dynamodb')
table_name = os.getenv("Name")

def lambda_handler(event, context):
    try:
        table = dynamodb.Table(table_name)

        response = table.get_item(
            Key={
                "nb": "1"
            }
        )

        item = response.get("Item", {})

        return {
            "statusCode": 200,
            "body": json.dumps(item)
        }

    except Exception as e:
        print("ERROR:", str(e))
        return {
            "statusCode": 500,
            "body": "error richou"
        }