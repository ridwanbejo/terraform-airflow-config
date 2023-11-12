terraform {
  required_version = ">= 1.4"

  required_providers {
    airflow = {
      source  = "DrFaust92/airflow"
      version = "0.13.1"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

provider "airflow" {
  base_endpoint = var.airflow_hostname
  username      = var.airflow_username
  password      = var.airflow_password
}
