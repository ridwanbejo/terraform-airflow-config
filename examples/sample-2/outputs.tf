output "airflow_variables" {
  description = "Current Airflow variables"
  value       = module.tf_airflow_config.airflow_variables
}

output "airflow_pools" {
  description = "Current Airflow pools"
  value       = module.tf_airflow_config.airflow_pools
}

output "airflow_connections" {
  description = "Current Airflow connections"
  value       = module.tf_airflow_config.airflow_connections
}
