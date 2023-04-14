# AWS Eventbridge
resource "aws_cloudwatch_event_bus" "lacework_alerts_eventbridge_event_bus" {
  name = var.aws_eventbridge_event_bus_name
}

data "aws_iam_policy_document" "lacework_event_bus_policy_document" {
  statement {
    sid    = "allow_account_to_put_events"
    effect = "Allow"
    actions = [
      "events:PutEvents",
    ]
    resources = [
      aws_cloudwatch_event_bus.lacework_alerts_eventbridge_event_bus.arn
    ]

    principals {
      type        = "AWS"
      identifiers = ["434813966438"]
    }
  }
}

resource "aws_cloudwatch_event_bus_policy" "lacework_event_bus_policy" {
  policy         = data.aws_iam_policy_document.lacework_event_bus_policy_document.json
  event_bus_name = aws_cloudwatch_event_bus.lacework_alerts_eventbridge_event_bus.name
}

resource "aws_cloudwatch_event_rule" "lacework_alerts_eventbridge_event_rule" {
  name        = var.aws_eventbridge_event_rule_name
  description = "Capture each Lacework alert"
  event_bus_name = aws_cloudwatch_event_bus.lacework_alerts_eventbridge_event_bus.name

  event_pattern = <<EOF
{
  "account": ["434813966438"]
}
EOF
}

resource "aws_cloudwatch_event_target" "sqs" {
  rule      = aws_cloudwatch_event_rule.lacework_alerts_eventbridge_event_rule.name
  target_id = "SendToSQS"
  arn       = aws_sqs_queue.lacework_alerts_queue.arn
  event_bus_name = aws_cloudwatch_event_bus.lacework_alerts_eventbridge_event_bus.name
}

# Lacework alert channel
resource "lacework_alert_channel_aws_cloudwatch" "all_events" {
  name            = var.lacework_eventbridge_alert_channel_name
  event_bus_arn   = aws_cloudwatch_event_bus.lacework_alerts_eventbridge_event_bus.arn
  group_issues_by = "Events"
}

# AWS Lambda
resource "aws_lambda_function" "lacework_sqs_to_s3" {
  # If the file is not in the current working directory you will need to include a 
  # path.module in the filename.
  filename      = "${path.module}/lambda.zip"
  function_name = "lacework_sqs_to_s3"
  role          = aws_iam_role.lacework_alerts_lambda_execution_role.arn
  handler       = "index.handler"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = filebase64sha256("${path.module}/index.js")

  runtime = "nodejs12.x"

  environment {
    variables = {
      S3_BUCKET_NAME = "${var.aws_s3_bucket_name}"
    }
  }
}

resource "aws_iam_role" "lacework_alerts_lambda_execution_role" {
  name = "lacework_lambda_execution_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# See also the following AWS managed policy: AWSLambdaBasicExecutionRole
resource "aws_iam_policy" "lacework_alerts_lambda_execution_policy" {
  name        = "lacework_alerts_lambda_execution_role"
  path        = "/"
  description = "IAM policy for Lacework lambda function for passing alert data from sqs to s3"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "SQS:ChangeMessageVisibility",
        "SQS:DeleteMessage",
        "SQS:ReceiveMessage",
        "SQS:GetQueueAttributes"
      ],
      "Resource": "${aws_sqs_queue.lacework_alerts_queue.arn}",
      "Effect": "Allow"
    },
    {
      "Action": [
        "s3:GetObject",
        "s3:PutObject"
      ],
      "Resource": "${aws_s3_bucket.lacework_alerts_bucket.arn}/*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda-role-policy-attach" {
  role       = aws_iam_role.lacework_alerts_lambda_execution_role.name
  policy_arn = aws_iam_policy.lacework_alerts_lambda_execution_policy.arn
}

resource "aws_lambda_event_source_mapping" "lacework-alerts-sqs-to-lambda" {
  event_source_arn = aws_sqs_queue.lacework_alerts_queue.arn
  function_name    = aws_lambda_function.lacework_sqs_to_s3.arn
}

# AWS S3
# Bucket
resource "aws_s3_bucket" "lacework_alerts_bucket" {
  bucket = var.aws_s3_bucket_name
}

resource "aws_s3_bucket_ownership_controls" "alerts_bucket_ownership_controls" {
  bucket = aws_s3_bucket.lacework_alerts_bucket.id

  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.lacework_alerts_bucket.id
  acl    = "private"
}

# AWS SQS
resource "aws_sqs_queue" "lacework_alerts_queue" {
  name                      = var.aws_sqs_queue_name
  delay_seconds             = 0
  max_message_size          = 262144
  message_retention_seconds = 345600
  receive_wait_time_seconds = 0
}

# data "aws_iam_policy_document" "sqs_send_message_policy" {
#   statement {
#     effect  = "Allow"
#     actions = ["SQS:SendMessage"]

#     principals {
#       type        = "Service"
#       identifiers = ["events.amazonaws.com"]
#     }

#     resources = [aws_sqs_queue.lacework_alerts_queue.arn]
#   }
# }

resource "aws_sqs_queue_policy" "lacework_alerts_queue_policy" {
  queue_url = aws_sqs_queue.lacework_alerts_queue.id
  policy = <<POLICY
  {
  "Version": "2008-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "lacework_eventbridge_event_bus_sender_policy",
      "Effect": "Allow",
      "Principal": {
        "Service": "events.amazonaws.com"
      },
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.lacework_alerts_queue.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_cloudwatch_event_rule.lacework_alerts_eventbridge_event_rule.arn}"
        }
      }
    }
  ]
}
POLICY
}