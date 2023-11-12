<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4 |
| <a name="requirement_airflow"></a> [airflow](#requirement\_airflow) | 0.13.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_airflow"></a> [airflow](#provider\_airflow) | 0.13.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [airflow_connection.connections](https://registry.terraform.io/providers/DrFaust92/airflow/0.13.1/docs/resources/connection) | resource |
| [airflow_pool.pools](https://registry.terraform.io/providers/DrFaust92/airflow/0.13.1/docs/resources/pool) | resource |
| [airflow_variable.variables](https://registry.terraform.io/providers/DrFaust92/airflow/0.13.1/docs/resources/variable) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_airflow_hostname"></a> [airflow\_hostname](#input\_airflow\_hostname) | n/a | `string` | n/a | yes |
| <a name="input_airflow_password"></a> [airflow\_password](#input\_airflow\_password) | n/a | `string` | n/a | yes |
| <a name="input_airflow_username"></a> [airflow\_username](#input\_airflow\_username) | n/a | `string` | n/a | yes |
| <a name="input_connections"></a> [connections](#input\_connections) | n/a | <pre>list(object({<br>    connection_id = string<br>    conn_type     = string<br>    host          = optional(string)<br>    description   = optional(string)<br>    login         = optional(string)<br>    schema        = optional(string)<br>    port          = optional(number)<br>    password      = optional(string)<br>    extra         = optional(any)<br>  }))</pre> | n/a | yes |
| <a name="input_pools"></a> [pools](#input\_pools) | n/a | <pre>list(object({<br>    name  = string<br>    slots = number<br>  }))</pre> | n/a | yes |
| <a name="input_variables"></a> [variables](#input\_variables) | n/a | <pre>list(object({<br>    key   = string<br>    value = string<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_airflow_connections"></a> [airflow\_connections](#output\_airflow\_connections) | List of Airflow connections |
| <a name="output_airflow_pools"></a> [airflow\_pools](#output\_airflow\_pools) | List of Airflow pools |
| <a name="output_airflow_variables"></a> [airflow\_variables](#output\_airflow\_variables) | List of Airflow variables |
<!-- END_TF_DOCS -->
