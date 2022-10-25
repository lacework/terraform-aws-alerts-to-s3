###################################
# AWS variables
###################################
variable "aws_profile" {
  type = string
  description = "The AWS CLI profile to use to authenticate with AWS"
}

variable "aws_region" {
  type = string
  description = "The AWS region to create the resources in"
}

variable "aws_eventbridge_event_bus_name" {
  type = string
  default = "Lacework_Alerts_Event_Bus"
  description = "The name of the AWS EventBridge to be created"
}

variable "aws_eventbridge_event_rule_name" {
  type = string
  default = "Lacework_Alerts_Event_Rule"
  description = "The name of the AWS EventBridge rule to be created"
}

variable "aws_sqs_queue_name" {
  type = string
  default = "Lacework_Alerts_SQS_Queue_Name"
  description = "The name of the SQS queue to be created"
}

variable "aws_s3_bucket_name" {
  type = string
  description = "The name of the S3 bucket to be created"
}

###################################
# Lacework variables
###################################
variable "lacework_profile" {
  type = string
  default = "default"
  description = "The Lacework CLI profile to be used to authenticate with Lacework"
}

variable "lacework_eventbridge_alert_channel_name" {
  type = string
  default = "Alerts to AWS S3 via EventBridge"
  description = "The name of the Lacework alert channel to be created"
}

