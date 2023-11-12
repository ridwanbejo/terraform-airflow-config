# Terraform Airflow Config

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

  # module.tf_airflow_config.airflow_variable.variables["TEST_VAR_1"] will be created
  + resource "airflow_variable" "variables" {
      + id    = (known after apply)
      + key   = "TEST_VAR_1"
      + value = "my value"
    }

  # module.tf_airflow_config.airflow_variable.variables["TEST_VAR_2"] will be created
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

module.tf_airflow_config.airflow_variable.variables["TEST_VAR_1"]: Creating...
module.tf_airflow_config.airflow_variable.variables["TEST_VAR_2"]: Creating...
module.tf_airflow_config.airflow_pool.pools["test-pool-1"]: Creating...
module.tf_airflow_config.airflow_pool.pools["test-pool-2"]: Creating...
module.tf_airflow_config.airflow_connection.connections["test-connection-1"]: Creating...
module.tf_airflow_config.airflow_connection.connections["test-connection-2"]: Creating...
module.tf_airflow_config.airflow_pool.pools["test-pool-1"]: Creation complete after 0s [id=test-pool-1]
2023-11-12T17:47:34.107+0700 [WARN]  Provider "module.tf_airflow_config.provider[\"registry.terraform.io/drfaust92/airflow\"]" produced an unexpected new value for module.tf_airflow_config.airflow_connection.connections["test-connection-2"], but we are tolerating it because it is using the legacy plugin SDK.
    The following problems may be the cause of any confusing errors from downstream operations:
      - .extra: was cty.StringVal("{\"sslca\":\"/tmp/server-ca.pem\",\"sslcert\":\"/tmp/client-cert.pem\",\"sslkey\":\"/tmp/client-key.pem\",\"sslmode\":\"verify-ca\"}"), but now cty.StringVal("{\"sslca\": \"/tmp/server-ca.pem\", \"sslcert\": \"/tmp/client-cert.pem\", \"sslkey\": \"/tmp/client-key.pem\", \"sslmode\": \"verify-ca\"}")
module.tf_airflow_config.airflow_connection.connections["test-connection-2"]: Creation complete after 0s [id=test-connection-2]
2023-11-12T17:47:34.274+0700 [WARN]  Provider "module.tf_airflow_config.provider[\"registry.terraform.io/drfaust92/airflow\"]" produced an unexpected new value for module.tf_airflow_config.airflow_connection.connections["test-connection-1"], but we are tolerating it because it is using the legacy plugin SDK.
    The following problems may be the cause of any confusing errors from downstream operations:
      - .extra: was cty.StringVal("{\"charset\":\"utf8\",\"cursor\":\"sscursor\",\"local_infile\":\"true\",\"unix_socket\":\"/var/socket\"}"), but now cty.StringVal("{\"charset\": \"utf8\", \"cursor\": \"sscursor\", \"local_infile\": \"true\", \"unix_socket\": \"/var/socket\"}")
module.tf_airflow_config.airflow_connection.connections["test-connection-1"]: Creation complete after 0s [id=test-connection-1]
module.tf_airflow_config.airflow_variable.variables["TEST_VAR_2"]: Creation complete after 0s [id=TEST_VAR_2]
module.tf_airflow_config.airflow_pool.pools["test-pool-2"]: Creation complete after 0s [id=test-pool-2]
module.tf_airflow_config.airflow_variable.variables["TEST_VAR_1"]: Creation complete after 0s [id=TEST_VAR_1]

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

### C.1. without using Hashicorp Vault

There are some scenarios that you could choose by using this module. For example:

1. you can create variables as shown at section B.  That's the only scenario.
2. you can create pools as shown at section B. That's the only scenario.
3. you can create multiple connections. But there are so many connection type that you have to find out. You can check in this official guide -> [Airflow - Managing Connections](https://airflow.apache.org/docs/apache-airflow/stable/howto/connection.html)
   1. for the extra field when you create connections, basically the data type is JSON format
   2. for the password, you can store the plain text on your tfvars. As long, you don't expose your repo to public. **But still it's huge threat for your company**.
   3. It's better for you to store the password at secret store solution such as Hashicorp Vault. Then, fetch the password to the Terraform project.
   4. You can check `examples/sample-2` to see how it works.

### C.2. by using Hashicorp Vault

Vault token is required. Please export the Vault token on your environment once you get it from your system administrator:

```
# for example
export TF_VAR_vault_token=myroot
```

Below is `airflow_connections` in `terraform.tfvars` with Vault integration. Ensure that you leave the password with empty string:

```
airflow_connections = [
  {
    connection_id = "test-connection-1"
    conn_type     = "mysql"
    host          = "10.101.80.90"
    description   = "lorem ipsum sit dolor amet - 1"
    port          = 3306
    login         = "mysql_user"
    password      = ""
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
    conn_type     = "postgres"
    host          = "10.101.80.92"
    description   = "lorem ipsum sit dolor amet - 2"
    port          = 5432
    login         = "pguser"
    password      = ""
    schema        = "your_schema"
    extra = {
      sslmode = "verify-ca"
      sslcert = "/tmp/client-cert.pem"
      sslca   = "/tmp/server-ca.pem"
      sslkey  = "/tmp/client-key.pem"
    }
  },
  {
    connection_id = "test-connection-3"
    conn_type     = "oracle"
    host          = "10.101.80.93"
    description   = "lorem ipsum sit dolor amet - 3"
    port          = 1521
    login         = "mydba"
    password      = ""
    schema        = "ora_schema"
    extra = {
      sslmode = "verify-ca"
      sslcert = "/tmp/client-cert.pem"
      sslca   = "/tmp/server-ca.pem"
      sslkey  = "/tmp/client-key.pem"
    }
  },
  {
    connection_id = "test-connection-4"
    conn_type     = "mysql"
    host          = "10.101.80.94"
    description   = "lorem ipsum sit dolor amet - 4"
    port          = 3306
    login         = "myadmin"
    password      = ""
    schema        = "myr_schema"
    extra = {
      sslmode = "verify-ca"
      sslcert = "/tmp/client-cert.pem"
      sslca   = "/tmp/server-ca.pem"
      sslkey  = "/tmp/client-key.pem"
    }
  }
]
```

Now, we have to configure Vault at `providers.tf`. First, you include the provider. Second, you choose the Vault path to fetch your keys:

```
terraform {
  required_version = ">= 1.4"

  required_providers {
    airflow = {
      source  = "DrFaust92/airflow"
      version = "0.13.1"
    }

    vault = {
      source  = "hashicorp/vault"
      version = "1.3.3"
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
```

Now, the most important part of the Vault integration with Terraform project is your logic at `locals.tf` which is totally different with `sample-1``. You have to load the secret based on your vault key naming format (e.g. `<connection_id>_<conn_type>_password`):

```
locals {
  pools     = var.airflow_pools
  variables = var.airflow_variables
  connections = [
    for conn in var.airflow_connections : {
      connection_id = conn["connection_id"]
      conn_type     = conn["conn_type"]
      host          = conn["host"]
      description   = conn["description"]
      port          = conn["port"]
      login         = conn["login"]
      schema        = conn["schema"]
      extra         = conn["extra"]
      password      = can(data.vault_generic_secret.tf_airflow_connection_passwords.data[format("%s_%s_password", conn.connection_id, conn.conn_type)]) ? data.vault_generic_secret.tf_airflow_connection_passwords.data[format("%s_%s_password", conn.connection_id, conn.conn_type)] : ""
    }
  ]
}

```

Before you run your Terraform project, please ensure that you store the connection passwords at Vault such below:

![](https://user-images.githubusercontent.com/907116/282330063-cf6b498c-bde4-48a1-b18b-2165ef272880.png)

Now you can re-run your project and see how it will be:

```
$ terraform init
$ terraform plan
$ terraform apply -auto-approve
```

You can see your connection passwords at Vault are written in `terraform.tfstate`:

```
...
        {
          "index_key": "test-connection-1",
          "schema_version": 0,
          "attributes": {
            ...
            "id": "test-connection-1",
            "login": "mysql_user",
            "password": "mypassword_12345",
            "port": 3306,
            "schema": "my_schema"
          },
          ...
        },
        {
          "index_key": "test-connection-2",
          "schema_version": 0,
          "attributes": {
            ...
            "id": "test-connection-2",
            "login": "pguser",
            "password": "pgpassword_12345",
            "port": 5432,
            "schema": "your_schema"
          },
          ...
        },
...
```

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

If you find any issue, you can raise it here at our [Issue Tracker](https://github.com/ridwanbejo/terraform-airflow-config/issues)

If you have something that you want to merge to this repo, just raise [Pull Requests](https://github.com/ridwanbejo/terraform-airflow-config/pulls)

Ensure that you install all the tools from section D. for development purpose.
