### These env vars are just example. Don't copy paste these lines below ###
# export TF_VAR_airflow_username=airflow
# export TF_VAR_airflow_password=airflow

module "tf_airflow_users" {
  source = "../../"

  airflow_hostname = "http://localhost:8080"
  airflow_username = var.airflow_username
  airflow_password = var.airflow_password
  pools            = local.pools
  variables        = local.variables
  connections      = local.connections
}
