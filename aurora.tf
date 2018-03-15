data "aws_availability_zones" "available" {}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count                 = 3
  identifier            = "${var.AURORA_CLUSTER_NAME}-aurora-instance-${count.index}"
  cluster_identifier    = "${aws_rds_cluster.aurora-poc.id}"
  instance_class        = "${var.AURORA_INSTANCE_CLASS}"
  db_subnet_group_name  = "${aws_db_subnet_group.aurora_subnet_group.name}"
  publicly_accessible   = false

  tags {
    Name         = "${var.ENVIRONMENT_NAME}-aurora-instance-${count.index}"
    ManagedBy    = "terraform"
    Environment  = "${var.ENVIRONMENT_NAME}"
  }
}

resource "aws_rds_cluster" "aurora-poc" {
  cluster_identifier              = "${var.AURORA_CLUSTER_NAME}"
  availability_zones              = ["${data.aws_availability_zones.available.names}"]
  database_name                   = "${var.DATABASE_NAME}"
  master_username                 = "${var.MASTER_USERNAME}"
  master_password                 = "${var.MASTER_PASSWORD}"
  backup_retention_period         = 14
  preferred_backup_window         = "02:00-03:00"
  preferred_maintenance_window    = "wed:03:00-wed:04:00"
  db_subnet_group_name            = "${aws_db_subnet_group.aurora_subnet_group.name}"
  final_snapshot_identifier       = "aurora-poc-cluster"
  vpc_security_group_ids        = [
    "${aws_security_group.allow-aurora.id}"
  ]

  tags {
    Name         = "${var.ENVIRONMENT_NAME}-Aurora-DB-Cluster"
    ManagedBy    = "terraform"
    Environment  = "${var.ENVIRONMENT_NAME}"
  }
}

resource "aws_db_subnet_group" "aurora_subnet_group" {

    name          = "${var.ENVIRONMENT_NAME}_aurora_db_subnet_group"
    description   = "Allowed subnets for Aurora DB cluster instances"
    subnet_ids    = [
      "${aws_subnet.aurora-private-1.id}",
      "${aws_subnet.aurora-private-2.id}",
      "${aws_subnet.aurora-private-3.id}"
    ]

    tags {
        Name         = "${var.ENVIRONMENT_NAME}-Aurora-DB-Subnet-Group"
        ManagedBy    = "terraform"
        Environment  = "${var.ENVIRONMENT_NAME}"
    }

}

