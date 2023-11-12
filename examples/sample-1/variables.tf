variable "airflow_username" {
  type = string
}

variable "airflow_password" {
  type = string
}

variable "airflow_variables" {
  type    = list(any)
  default = []
}

variable "airflow_pools" {
  type    = list(any)
  default = []
}

variable "airflow_connections" {
  type    = list(any)
  default = []
}
