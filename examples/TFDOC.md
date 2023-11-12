<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4 |
| <a name="requirement_airflow"></a> [airflow](#requirement\_airflow) | 0.13.1 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tf_airflow_users"></a> [tf\_airflow\_users](#module\_tf\_airflow\_users) | ../ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_airflow_connections"></a> [airflow\_connections](#input\_airflow\_connections) | n/a | `list(any)` | `[]` | no |
| <a name="input_airflow_password"></a> [airflow\_password](#input\_airflow\_password) | n/a | `string` | n/a | yes |
| <a name="input_airflow_pools"></a> [airflow\_pools](#input\_airflow\_pools) | n/a | `list(any)` | `[]` | no |
| <a name="input_airflow_username"></a> [airflow\_username](#input\_airflow\_username) | n/a | `string` | n/a | yes |
| <a name="input_airflow_variables"></a> [airflow\_variables](#input\_airflow\_variables) | n/a | `list(any)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_airflow_connections"></a> [airflow\_connections](#output\_airflow\_connections) | Current Airflow connections |
| <a name="output_airflow_pools"></a> [airflow\_pools](#output\_airflow\_pools) | Current Airflow pools |
| <a name="output_airflow_variables"></a> [airflow\_variables](#output\_airflow\_variables) | Current Airflow variables |
<!-- END_TF_DOCS -->
