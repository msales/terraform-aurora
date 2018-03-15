variable "AWS_REGION" {
  default = "eu-central-1"
}
variable "PATH_TO_PRIVATE_KEY" {
  default = "aurora-poc-instance.pem"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "aurora-poc-instance.pub"
}
variable "AMIS" {
  type = "map"
  default = {
    us-east-1     = "ami-13be557e"
    us-west-2     = "ami-06b94666"
    eu-west-1     = "ami-844e0bf7"
    eu-central-1  = "ami-7c412f13"
  }
}
variable "AURORA_CLUSTER_NAME" {
  default = "aurora-poc"
}
variable "DATABASE_NAME" {
  default = "dbpoc"
}
variable "MASTER_USERNAME" {
  default = "auroraadmin"
}
variable "MASTER_PASSWORD" {
  default = "auroraadmin"
}
variable "AURORA_INSTANCE_CLASS" {
  default = "db.r4.large"
}
variable "ENVIRONMENT_NAME" {
  default = "aurora_poc"
}
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
