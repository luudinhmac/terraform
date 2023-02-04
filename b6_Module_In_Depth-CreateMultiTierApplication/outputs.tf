output "db_password" {
  value = module.database.config.password
  sensitive = true
}

output "lb_db_dns" {
    value = module.autoscaling.lb_dns
}