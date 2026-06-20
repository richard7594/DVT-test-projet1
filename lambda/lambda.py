import boto3
import os
import json

dynamodb = boto3.client('dynamodb')
table_name = os.getenv("Name")

def lambda_handler(event, context):
    print(f"{event} \n")
    try:
      
      get_item(event) 
       
    except Exception as e:
        print("ERROR:", str(e))
        return {
            "statusCode": 500,
            "body": "error"
        }
    
def get_item (event): 

    queryString = event.get('queryStringParameters', '')  
    id = queryString.get('id', 1)

    response = dynamodb.get_item(
         TableName= table_name,
         key={ 'id' : id }
    )

    return {
        "statusCode": 200,
        "body": json.dumps(response)
    }