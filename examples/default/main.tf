provider "lacework" {}

provider "aws" {}

module "lacework_alerts_to_s3" {
  source = "../.."
  aws_s3_bucket_name = "laceworkAlertsBucketUniqueName-xyz" # required
}
