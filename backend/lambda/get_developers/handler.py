from typing import Any, Dict
from aws_lambda_powertools.utilities.typing import LambdaContext
import json


def handler(event: Dict[str, Any], context: LambdaContext) -> Dict[str, Any]:
    """
    Lambda handler function.

    Args:
        event (Dict[str, Any]): The event object passed to the Lambda function.
                                 Its structure depends on the event source (e.g., S3, API Gateway).
        context (LambdaContext): The context object, providing runtime information about the invocation.

    Returns:
        Dict[str, Any]: The response object returned by the Lambda function.
                        Its structure depends on the integration (e.g., API Gateway expects specific format).
    """
    return {
        "statusCode": 200,
        "body": json.dumps([
            {
                "firstName": "João",
                "lastName": "Ferreira",
                "email": "joaosilvaferreira.dev@gmail.com"
            }
        ])
    }