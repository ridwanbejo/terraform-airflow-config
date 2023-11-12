variable "airflow_hostname" {
  type = string
}

variable "airflow_username" {
  type = string
}

variable "airflow_password" {
  type = string
}

variable "variables" {
  type = list(object({
    key   = string
    value = string
  }))
}

variable "pools" {
  type = list(object({
    name  = string
    slots = number
  }))
}

variable "connections" {
  type = list(object({
    connection_id = string
    conn_type     = string
    host          = string
    decription    = string
    login         = string
    schema        = string
    port          = string
    password      = string
    extra         = string
  }))
}
