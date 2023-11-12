locals {
  pools     = var.airflow_pools
  variables = var.airflow_variables
  connections = [
    for conn in var.airflow_connections : {
      connection_id = conn["connection_id"]
      conn_type     = conn["conn_type"]
      host          = conn["host"]
      description   = conn["description"]
      port          = conn["port"]
      login         = conn["login"]
      schema        = conn["schema"]
      extra         = conn["extra"]
      password      = can(data.vault_generic_secret.tf_airflow_connection_passwords.data[format("%s_%s_password", conn.connection_id, conn.conn_type)]) ? data.vault_generic_secret.tf_airflow_connection_passwords.data[format("%s_%s_password", conn.connection_id, conn.conn_type)] : ""
    }
  ]
}
