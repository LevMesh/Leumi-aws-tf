import boto3

def lambda_handler(event, context):
    # Set up the S3 client
    s3 = boto3.client('s3')
    
    # Define the source and destination bucket names
    source_bucket_name = 'lev-leumi-bucket'
    destination_bucket_name = 'lev-leumi-internal-bucket'
    
    # Define the prefix to search for
    prefix = 'file'
    
    try:
        # Get the objects from the source S3 bucket that match the prefix
        response = s3.list_objects_v2(Bucket=source_bucket_name, Prefix=prefix)
        
        # Iterate over the objects and copy each one to the destination bucket
        for object in response['Contents']:
            object_key = object['Key']
            s3.copy_object(Bucket=destination_bucket_name, CopySource={'Bucket': source_bucket_name, 'Key': object_key}, Key=object_key)
        
        return {
            'statusCode': 200,
            'body': 'Successfully copied objects from source bucket to destination bucket'
        }
    except Exception as e:
        print(e)
        return {
            'statusCode': 500,
            'body': 'Error copying objects from source bucket to destination bucket'
        }
