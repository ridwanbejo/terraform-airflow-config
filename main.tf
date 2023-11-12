resource "airflow_variable" "variables" {
  for_each = { for idx, item in var.variables : item.key => item }

  key   = each.value.key
  value = each.value.value
}

resource "airflow_pool" "pools" {
  for_each = { for idx, item in var.pools : item.name => item }

  name  = each.value.name
  slots = each.value.slots
}

resource "airflow_connection" "connections" {
  for_each = { for idx, item in var.connections : item.connection_id => item }

  connection_id = each.value.connection_id
  conn_type     = each.value.conn_type
  host          = each.value.host
  description   = each.value.description
  login         = each.value.login
  schema        = each.value.schema
  port          = each.value.port
  password      = each.value.password
  extra         = jsonencode(each.value.extra)
}
