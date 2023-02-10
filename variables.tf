variable "region" {
    default = "eu-west-1"
    description = "AWS Region to deploy to"
}
variable "sqs" {
    default = "coreloggings3-event-notification-queue"
    description = "Common prefix for all Terraform created resources"
}
 variable "bucket" {
    default = "chichoos3"
    description = "Common prefix for all Terraform created resources"
}

