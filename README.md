<a href="https://lacework.com"><img src="https://techally-content.s3-us-west-1.amazonaws.com/public-content/lacework_logo_full.png" width="600"></a>

# terraform-lacework-alerts-to-aws-s3

[![GitHub release](https://img.shields.io/github/release/lacework/terraform-lacework-alerts-to-aws-s3.svg)](https://github.com/lacework/terraform-lacework-alerts-to-aws-s3/releases/)
[![Codefresh build status]( https://g.codefresh.io/api/badges/pipeline/lacework/terraform-modules%2Ftest-compatibility?type=cf-1&key=eyJhbGciOiJIUzI1NiJ9.NWVmNTAxOGU4Y2FjOGQzYTkxYjg3ZDEx.RJ3DEzWmBXrJX7m38iExJ_ntGv4_Ip8VTa-an8gBwBo)]( https://g.codefresh.io/pipelines/edit/new/builds?id=607e25e6728f5a6fba30431b&pipeline=test-compatibility&projects=terraform-modules&projectId=607db54b728f5a5f8930405d)

A Terraform Module to pipe alerts from Lacework via AWS Eventbridge to an AWS S3 bucket with Lacework.

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

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |
| <a name="requirement_lacework"></a> [lacework](#requirement\_lacework) | ~> 0.20.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.75.2 |
| <a name="provider_lacework"></a> [lacework](#provider\_lacework) | 0.20.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_bus.lacework_alerts_eventbridge_event_bus](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_bus) | resource |
| [aws_cloudwatch_event_bus_policy.lacework_event_bus_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_bus_policy) | resource |
| [aws_cloudwatch_event_rule.lacework_alerts_eventbridge_event_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.sqs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_iam_policy.lacework_alerts_lambda_execution_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.lacework_alerts_lambda_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.lambda-role-policy-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_event_source_mapping.lacework-alerts-sqs-to-lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_event_source_mapping) | resource |
| [aws_lambda_function.lacework_sqs_to_s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_s3_bucket.lacework_alerts_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_sqs_queue.lacework_alerts_queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue_policy.lacework_alerts_queue_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy) | resource |
| [lacework_alert_channel_aws_cloudwatch.all_events](https://registry.terraform.io/providers/lacework/lacework/latest/docs/resources/alert_channel_aws_cloudwatch) | resource |
| [aws_iam_policy_document.lacework_event_bus_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_eventbridge_event_bus_name"></a> [aws\_eventbridge\_event\_bus\_name](#input\_aws\_eventbridge\_event\_bus\_name) | The name of the AWS EventBridge to be created | `string` | `"Lacework_Alerts_Event_Bus"` | no |
| <a name="input_aws_eventbridge_event_rule_name"></a> [aws\_eventbridge\_event\_rule\_name](#input\_aws\_eventbridge\_event\_rule\_name) | The name of the AWS EventBridge rule to be created | `string` | `"Lacework_Alerts_Event_Rule"` | no |
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | The AWS CLI profile to use to authenticate with AWS | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region to create the resources in | `string` | n/a | yes |
| <a name="input_aws_s3_bucket_name"></a> [aws\_s3\_bucket\_name](#input\_aws\_s3\_bucket\_name) | The name of the S3 bucket to be created | `string` | n/a | yes |
| <a name="input_aws_sqs_queue_name"></a> [aws\_sqs\_queue\_name](#input\_aws\_sqs\_queue\_name) | The name of the SQS queue to be created | `string` | `"Lacework_Alerts_SQS_Queue_Name"` | no |
| <a name="input_lacework_eventbridge_alert_channel_name"></a> [lacework\_eventbridge\_alert\_channel\_name](#input\_lacework\_eventbridge\_alert\_channel\_name) | The name of the Lacework alert channel to be created | `string` | `"Alerts to AWS S3 via EventBridge"` | no |
| <a name="input_lacework_profile"></a> [lacework\_profile](#input\_lacework\_profile) | The Lacework CLI profile to be used to authenticate with Lacework | `string` | `"default"` | no |

## Outputs

No outputs.

## Terraform install

### Prequisites
[Install the Lacework CLI](https://docs.lacework.com/cli#installation), [create an API Key](https://docs.lacework.com/cli#create-api-key) and [configure the CLI with the API key](https://docs.lacework.com/cli#configure-the-cli). [Install the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) and configure a profile.

1. Clone the repo
2. `cd terraform`
3. `terraform init`
4. `terraform plan/apply`

## Manual install

1. Create an [event bridge integration](https://docs.lacework.com/amazon-event-bridge#create-resources-within-your-aws-account)
2. Create a new Lambda function based on the `hello-world` blueprint. Copy the code from [index.js](https://raw.githubusercontent.com/lacework/terraform-lacework-alerts-to-aws-s3/main/index.js) into the new function
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
