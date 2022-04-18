module "mysqldb" {
  source            = "./mysqldb"
  aws_region        = var.aws_region
  db_name           = var.db_name
  db_username       = var.db_username
  db_password       = var.db_password
  db_port           = var.db_port
  db_instance_class = var.db_instance_class
}