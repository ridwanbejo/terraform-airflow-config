terraform {
  required_version = ">= 1.4"

  required_providers {
    airflow = {
      source  = "DrFaust92/airflow"
      version = "0.13.1"
    }

    random = {
      version = "3.5.1"
    }
  }
}
