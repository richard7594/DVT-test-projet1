import boto3
import os
import json

dynamodb = boto3.client('dynamodb')
table_name = os.getenv("Name")

def lambda_handler(event, context):
    print(f"{event} \n")
    try:
       
        id = event.get('id', 1)      
           
        table = dynamodb.Table(table_name)
        response = table.get_item(
            Key={
                "Id": id
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
            "body": "error"
        }