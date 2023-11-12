output "airflow_variables" {
  description = "List of Airflow variables"
  value       = { for item in airflow_variable.variables : item.key => item.value }
}

output "airflow_pools" {
  description = "List of Airflow pools"
  value       = { for item in airflow_pool.pools : item.name => item.slots }
}

output "airflow_connections" {
  description = "List of Airflow connections"
  value       = { for item in airflow_connection.connections : item.connection_id => item.conn_type }
}
