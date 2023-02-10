provider "aws" {
    region = var.region
}

# SQS queue
resource "aws_sqs_queue" "queue" {
  name = var.sqs
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "arn:aws:sqs:*:*:${var.sqs}",
      "Condition": {"ArnEquals": {"aws:SourceArn": "${data.aws_s3_bucket.bucket.arn}"}}
    }
  ]
}
POLICY
}
# S3 bucket
data "aws_s3_bucket" "bucket" {
  bucket = var.bucket

}
# S3 event filter
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = data.aws_s3_bucket.bucket.id
  queue {
    queue_arn     = aws_sqs_queue.queue.arn
    events        = ["s3:ObjectCreated:*"]
  }
}