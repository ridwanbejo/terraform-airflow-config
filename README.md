# Terraform Airflow User

This is a Terraform module for managing configuration at Apache Airflow. You can use this module both for commercial or non-commercial purposes.

Currently, you can manage these resources in Airflow by using this module:

- Variables
- Pools
- Connect to Airflow API with Basic Auth

Tested in:

- Apache Airflow ✅
- Astronomer ❌

## A. Prerequisites

Requirements:

- Terraform with version >= 1.4
- DrFaust92/airflow
- Hashicorp/random
- Airflow hostname
- Airflow username -> `TF_VAR_airflow_username`
- Airflow password -> `TF_VAR_airflow_password`

## B. How to use this module for your Terraform project ?

- Copy `example` project from this module. You can extend it as per your requirements
- Configure Airflow hostname by modifying the `providers.tf`. For example `http://localhost:8080/`
- Configure `TF_VAR_airflow_username` and `TF_VAR_airflow_username` as environment variables. For example:

```
$ export TF_VAR_airflow_username=airflow
$ export TF_VAR_airflow_password=airflow
```

- Create `terraform.tfvars` inside the Project. Then copy this sample terraform.tfvars into the file:

```
airflow_variables = [
  {
    key   = "TEST_VAR_1"
    value = "my value"
  },
  {
    key   = "TEST_VAR_2"
    value = "your value"
  }
]

airflow_pools = [
  {
    name  = "test-pool-1"
    slots = 2
  },
  {
    name  = "test-pool-2"
    slots = 3
  }
]


airflow_connections = [
  {
    connection_id = "test-connection-1"
    conn_type     = "MySQL"
    host          = "10.101.80.90"
    description   = "lorem ipsum sit dolor amet - 1"
    port          = 3306
    login         = "mysql_user"
    password      = "mypassword" # THIS IS BAD PRACTICE. PLEASE USE VAULT INSTEAD...
    schema        = "my_schema"
    extra = {
      charset      = "utf8"
      cursor       = "sscursor"
      local_infile = "true"
      unix_socket  = "/var/socket"
    }
  },
  {
    connection_id = "test-connection-2"
    conn_type     = "Postgres"
    host          = "10.101.80.92"
    description   = "lorem ipsum sit dolor amet - 2"
    port          = 5432
    login         = "pguser"
    password      = "pgpassword" # THIS IS BAD PRACTICE. PLEASE USE VAULT INSTEAD...
    schema        = "your_schema"
    extra = {
      sslmode = "verify-ca"
      sslcert = "/tmp/client-cert.pem"
      sslca   = "/tmp/server-ca.pem"
      sslkey  = "/tmp/client-key.pem"
    }
  }
]
 ```

- Adjust the tfvars based on your requirements. The tfvars above is just example. Then, Save it
- Run these commands:

```
$ terraform init
$ terraform plan
```
This is the output when you run terraform plan successfully:

```
...

 # module.tf_airflow_users.airflow_pool.pools["test-pool-2"] will be created
  + resource "airflow_pool" "pools" {
      + id             = (known after apply)
      + name           = "test-pool-2"
      + occupied_slots = (known after apply)
      + open_slots     = (known after apply)
      + queued_slots   = (known after apply)
      + slots          = 3
      + used_slots     = (known after apply)
    }

  # module.tf_airflow_users.airflow_variable.variables["TEST_VAR_1"] will be created
  + resource "airflow_variable" "variables" {
      + id    = (known after apply)
      + key   = "TEST_VAR_1"
      + value = "my value"
    }

  # module.tf_airflow_users.airflow_variable.variables["TEST_VAR_2"] will be created
  + resource "airflow_variable" "variables" {
      + id    = (known after apply)
      + key   = "TEST_VAR_2"
      + value = "your value"
    }

Plan: 6 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + airflow_connections = {
      + test-connection-1 = "MySQL"
      + test-connection-2 = "Postgres"
    }
  + airflow_pools       = {
      + test-pool-1 = 2
      + test-pool-2 = 3
    }
  + airflow_variables   = {
      + TEST_VAR_1 = "my value"
      + TEST_VAR_2 = "your value"
    }
```

After you feel confidence with the terraform plan output, let's apply it.

```
$ terraform apply -auto-approve
```

- If it succeed, you must see this kind of output on your terminal

```
...

module.tf_airflow_users.airflow_variable.variables["TEST_VAR_2"]: Creating...
module.tf_airflow_users.airflow_variable.variables["TEST_VAR_1"]: Creating...
module.tf_airflow_users.airflow_connection.connections["test-connection-2"]: Creating...
module.tf_airflow_users.airflow_pool.pools["test-pool-2"]: Creating...
module.tf_airflow_users.airflow_connection.connections["test-connection-1"]: Creating...
module.tf_airflow_users.airflow_pool.pools["test-pool-1"]: Creating...
2023-11-12T17:10:28.483+0700 [WARN]  Provider "module.tf_airflow_users.provider[\"registry.terraform.io/drfaust92/airflow\"]" produced an unexpected new value for module.tf_airflow_users.airflow_connection.connections["test-connection-2"], but we are tolerating it because it is using the legacy plugin SDK.
    The following problems may be the cause of any confusing errors from downstream operations:
      - .extra: was cty.StringVal("{\"sslca\":\"/tmp/server-ca.pem\",\"sslcert\":\"/tmp/client-cert.pem\",\"sslkey\":\"/tmp/client-key.pem\",\"sslmode\":\"verify-ca\"}"), but now cty.StringVal("{\"sslca\": \"/tmp/server-ca.pem\", \"sslcert\": \"/tmp/client-cert.pem\", \"sslkey\": \"/tmp/client-key.pem\", \"sslmode\": \"verify-ca\"}")
module.tf_airflow_users.airflow_connection.connections["test-connection-2"]: Creation complete after 0s [id=test-connection-2]
2023-11-12T17:10:28.552+0700 [WARN]  Provider "module.tf_airflow_users.provider[\"registry.terraform.io/drfaust92/airflow\"]" produced an unexpected new value for module.tf_airflow_users.airflow_connection.connections["test-connection-1"], but we are tolerating it because it is using the legacy plugin SDK.
    The following problems may be the cause of any confusing errors from downstream operations:
      - .extra: was cty.StringVal("{\"charset\":\"utf8\",\"cursor\":\"sscursor\",\"local_infile\":\"true\",\"unix_socket\":\"/var/socket\"}"), but now cty.StringVal("{\"charset\": \"utf8\", \"cursor\": \"sscursor\", \"local_infile\": \"true\", \"unix_socket\": \"/var/socket\"}")
module.tf_airflow_users.airflow_connection.connections["test-connection-1"]: Creation complete after 1s [id=test-connection-1]
module.tf_airflow_users.airflow_variable.variables["TEST_VAR_1"]: Creation complete after 1s [id=TEST_VAR_1]
module.tf_airflow_users.airflow_variable.variables["TEST_VAR_2"]: Creation complete after 1s [id=TEST_VAR_2]
module.tf_airflow_users.airflow_pool.pools["test-pool-1"]: Creation complete after 1s [id=test-pool-1]
module.tf_airflow_users.airflow_pool.pools["test-pool-2"]: Creation complete after 1s [id=test-pool-2]

Apply complete! Resources: 6 added, 0 changed, 0 destroyed.

Outputs:

airflow_connections = {
  "test-connection-1" = "MySQL"
  "test-connection-2" = "Postgres"
}
airflow_pools = {
  "test-pool-1" = 2
  "test-pool-2" = 3
}
airflow_variables = {
  "TEST_VAR_1" = "my value"
  "TEST_VAR_2" = "your value"
}
```

Now you can check the Airflow variables, connections and pools at Admin section to see the applied changes.

## C. Understanding tfvars scenarios

There are some scenarios that you could choose by using this module. For example:

1. you can create variables as shown at section B.  That's the only scenario.
2. you can create pools as shown at section B. That's the only scenario.
3. you can create multiple connections. But there are so many connection type that you have to find out. You can check in this official guide -> [Airflow - Managing Connections](https://airflow.apache.org/docs/apache-airflow/stable/howto/connection.html)
4. for the extra field when you create connections, basically the data type is JSON format
5. for the password, better you store the password at secret store solution such as Hashicorp Vault. Then, fetch the password to the Terraform project. You can check `examples/sample-2` to see how it works. `DON'T STORE PASSWORD on YOUR TF FILES`

## D. Ensuring quality

I am trying to follow these approaches for ensuring quality of the tf-module:

- **validate**, ensure my Terraform module is in correct configuration based on Terraform guideline
- **auto-format**, ensure my Terraform script is edited with correct format based on Terraform guideline
- **linter**, ensure my Terraform script is in correct format based on Terraform guideline
- **tests**, ensure my Terraform module is processing correct variables and yield expected outputs
- **security**, ensure my Terraform module is free from CVE and stay compliance
- **automation**, run all above steps by using automation tool to improve development time and keep best quality before or after merging to Git repository


The tools:

- [terraform validate](https://developer.hashicorp.com/terraform/cli/commands)
- [terraform fmt](https://developer.hashicorp.com/terraform/cli/commands)
- [tflint](https://github.com/terraform-lint48ers/tflint)
- [terraform tests](https://developer.hashicorp.com/terraform/language/tests)
- [tfsec](https://github.com/aquasecurity/tfsec)
- [Pre-commit](https://pre-commit.com/)
- Github Action [Setup Terraform pipeline](https://github.com/hashicorp/setup-terraform)

## E. How to contribute ?

If you find any issue, you can raise it here at our [Issue Tracker](https://github.com/ridwanbejo/terraform-airflow-user/issues)

If you have something that you want to merge to this repo, just raise [Pull Requests](https://github.com/ridwanbejo/terraform-airflow-user/pulls)

Ensure that you install all the tools from section D. for development purpose.
