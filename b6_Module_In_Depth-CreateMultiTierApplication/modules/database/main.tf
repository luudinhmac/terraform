resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "aws_db_instance" "database" {
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "12.7"
  instance_class         = "db.t2.micro"
  identifier             = "${var.project}-db-instance"
  db_name                = "series"
  username               = "admin"
  password               = random_password.password.result
  db_subnet_group_name   = var.vpc.database_subnet_group
  vpc_security_group_ids = [var.sg.db]
  skip_final_snapshot    = true
}




# │ Error: creating RDS DB Instance (terraform-series-db-instance): InvalidParameterValue: Invalid DB engine
# │ 	status code: 400, request id: f8234627-be00-47c9-a125-5ab652921be0
# │ 
# │   with module.database.aws_db_instance.database,
# │   on modules/database/main.tf line 7, in resource "aws_db_instance" "database":
# │    7: resource "aws_db_instance" "database" {




