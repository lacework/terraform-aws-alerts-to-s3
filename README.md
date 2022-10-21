<a href="https://lacework.com"><img src="https://techally-content.s3-us-west-1.amazonaws.com/public-content/lacework_logo_full.png" width="600"></a>

# terraform-lacework-alerts-to-aws-s3

[![GitHub release](https://img.shields.io/github/release/lacework/terraform-lacework-alerts-to-aws-s3.svg)](https://github.com/lacework/terraform-lacework-alerts-to-aws-s3/releases/)
[![Codefresh build status]( https://g.codefresh.io/api/badges/pipeline/lacework/terraform-modules%2Ftest-compatibility?type=cf-1&key=eyJhbGciOiJIUzI1NiJ9.NWVmNTAxOGU4Y2FjOGQzYTkxYjg3ZDEx.RJ3DEzWmBXrJX7m38iExJ_ntGv4_Ip8VTa-an8gBwBo)]( https://g.codefresh.io/pipelines/edit/new/builds?id=607e25e6728f5a6fba30431b&pipeline=test-compatibility&projects=terraform-modules&projectId=607db54b728f5a5f8930405d)

A Terraform Module to pipe alerts from Lacework via AWS Eventbridge to an AWS S3 bucket with Lacework.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| aws_profile | The AWS CLI profile to use to authenticate with AWS | String | none | Yes |
| aws_region | The AWS region to create the resources in | String | none | Yes |
| aws_s3_bucket_name | The name of the S3 bucket to be created | String | none | Yes |
| aws_eventbridge_event_bus_name | The name of the AWS EventBridge to be created | String | Lacework_Alerts_Event_Bus | No |
| aws_eventbridge_event_rule_name | The name of the AWS EventBridge rule to be created | String | Lacework_Alerts_Event_Rule | No |
| aws_sqs_queue_name | The name of the SQS queue to be created | String | Lacework_Alerts_SQS_Queue_Name | No |
| lacework_profile | The Lacework CLI profile to be used to authenticate with Lacework | String | default | No |
| lacework_eventbridge_alert_channel_name | The name of the Lacework alert channel to be created | String | Alerts to AWS S3 via EventBridge | No |


## Outputs

This module has no outputs

## What does this do?

Creates resources in AWS and Lacework to pipe alerts from Lacework via AWS Eventbridge to an AWS S3 bucket.

The flows goes as so:

`Lacework -> AWS Eventbridge -> AWS SQS -> AWS Lambda function -> AWS S3 bucket`

The terraform module will create the following in your AWS account

1. AWS EventBridge Event Bus
2. AWS EventBridge Event Rule
3. AWS SQS Queue
4. AWS IAM role for Lambda function
5. AWS Lambda function to move JSON from SQS to S3
6. AWS S3 bucket to store the Alert JSON
7. Lacework event bridge alert channel

**NOTE: You still need to attach a Lacework [alert rule](https://docs.lacework.com/console/alert-rules) to the alert channel to route alerts to the channel.**

## Terraform install

### Prequisites
[Install the Lacework CLI](https://docs.lacework.com/cli#installation), [create an API Key](https://docs.lacework.com/cli#create-api-key) and [configure the CLI with the API key](https://docs.lacework.com/cli#configure-the-cli). [Install the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) and configure a profile.

1. Clone the repo
2. `cd terraform`
3. `terraform init`
4. `terraform plan/apply`

## Manual install

1. Create an [event bridge integration](https://docs.lacework.com/amazon-event-bridge#create-resources-within-your-aws-account)
2. Create a new Lambda function based on the `hello-world` blueprint. Copy the code from `index.js` into the new function
3. Edit the SQS Access Policy to enable the Lambda execution role to access it

```
{
    "Sid": "__receiver_statement",
    "Effect": "Allow",
    "Principal": {
    "AWS": "arn:aws:iam::<AWS_ACCOUNT_ID>:role/service-role/<LAMBDA_EXECUTION_ROLE_NAME>"
    },
    "Action": [
    "SQS:ChangeMessageVisibility",
    "SQS:DeleteMessage",
    "SQS:ReceiveMessage",
    "SQS:GetQueueAttributes"
    ],
    "Resource": "arn:aws:sqs:<YOUR_AWS_REGION>:<AWS_ACCOUNT_ID>:<SQS_QUEUE_NAME>"
}
```

4. Create a new S3 bucket where alerts will be sent.
5. In IAM add an inline policy to the Lambda execution role allowing it to write to S3 bucket

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ExampleStmt",
            "Action": [
                "s3:GetObject",
                "s3:PutObject"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::<BUCKET_NAME>/*"
            ]
        }
    ]
}
```
