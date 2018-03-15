terraform {
  backend "s3" {
    bucket = "tfstates-4h65j"
    key    = "rds-yh66d/rds.tfstate"
    region = "eu-central-1"
  }
}
