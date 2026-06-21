import boto3
import os
import json

dynamodb = boto3.client('dynamodb')
table_name = os.getenv("Name")

def lambda_handler(event, context):
    print(f"{event} \n")

    try:
      
      if event.get('httpMethod') == 'GET' :
        return get_item(event) 
      
    
    except Exception as e:
        print("ERROR:", str(e))
        return {
            "statusCode": 500,
            "body": "Error"
        }
    
def get_item (event): 

    queryString = event.get('queryStringParameters', '')  
    id = str(queryString.get('id', 1))
    tournoir = str(queryString.get('tournoir', ''))

    response = dynamodb.get_item(
         TableName = table_name,
         Key={ 'Id':{ 'N': id },
               'tournoir':{ 'S': tournoir }
             }
    )

    return {
        "statusCode": 200,
        "body": json.dumps(response)
    }

def put_item(event):

    queryString = event.get('queryStringParameters', '')  
    id = str(queryString.get('id', 1))
    tournoir = str(queryString.get('tournoir', ''))
    Nom = str(queryString.get('Nom', ''))
    Prenom = str(queryString.get('Prenom', ''))

    responce = dynamodb.put_item(

      TableName = table_name,
      Item={
          'Id':{ 'N': id },
          'tournoir':{ 'S': tournoir },
          'Nom':{ 'S': Nom },
          'Prenom':{ 'S': Prenom }
      }

    )

    return