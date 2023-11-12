terraform {
  required_version = ">= 1.4"

  required_providers {
    airflow = {
      source  = "DrFaust92/airflow"
      version = "0.13.1"
    }

    vault = {
      source  = "hashicorp/vault"
      version = "3.22.0"
    }
  }
}

provider "vault" {
  address = "http://localhost:8200"
  token   = var.vault_token
}

data "vault_generic_secret" "tf_airflow_connection_passwords" {
  path = "secret/tf-airflow"
}
