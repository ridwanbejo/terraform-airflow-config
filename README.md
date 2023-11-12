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
airflow_roles = [
  {
    name    = "custom-role-1"
    actions = [
      {
        name     = "can_read"
        resource = "Audit Logs"
      }
    ]
  },
  {
    name    = "custom-role-2"
    actions = [
      {
        name     = "can_read"
        resource = "Audit Logs"
      },
      {
        name     = "can_read"
        resource = "DAGs"
      }
    ]
  },
  {
    name    = "custom-role-3"
    actions = [
      {
        name     = "can_read"
        resource = "Variables"
      }
    ]
  },
]

airflow_users = [
  {
    email      = "ridwanbejo@gmail.com"
    first_name = "Ridwan"
    last_name  = "Bejo"
    username   = "ridwanbejo"
    roles      = ["Viewer"]
  },
  {
    email      = "sakura.machiya@gmail.com"
    first_name = "Sakura"
    last_name  = "Machiya"
    username   = "sakuramachi"
    roles      = ["Viewer"]
  },
  {
    email      = "peter.dart@gmail.com"
    first_name = "Peter"
    last_name  = "Dart"
    username   = "peterdart"
    roles      = ["custom-role-1"]
  },
  {
    email      = "eliza.fangerbau@gmail.com"
    first_name = "Eliza"
    last_name  = "Fangerbau"
    username   = "elizafang"
    roles      = ["custom-role-2"]
  },
  {
    email      = "michelle.wang@gmail.com"
    first_name = "Michelle"
    last_name  = "Wang"
    username   = "michwang"
    roles      = ["custom-role-2", "custom-role-3"]
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

 # module.tf_airflow_users.random_password.password["sakuramachi"] will be created
  + resource "random_password" "password" {
      + bcrypt_hash      = (sensitive value)
      + id               = (known after apply)
      + length           = 16
      + lower            = true
      + min_lower        = 0
      + min_numeric      = 0
      + min_special      = 0
      + min_upper        = 0
      + number           = true
      + numeric          = true
      + override_special = "!#$%&*()-_=+[]{}<>:?"
      + result           = (sensitive value)
      + special          = true
      + upper            = true
    }

Plan: 13 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + airflow_users = {
      + elizafang   = "eliza.fangerbau@gmail.com"
      + michwang    = "michelle.wang@gmail.com"
      + peterdart   = "peter.dart@gmail.com"
      + ridwanbejo  = "ridwanbejo@gmail.com"
      + sakuramachi = "sakura.machiya@gmail.com"
    }
```

After you feel confidence with the terraform plan output, let's apply it.

```
$ terraform apply -auto-approve
```

- If it succeed, you must see this kind of output on your terminal

```
...

module.tf_airflow_users.random_password.password["elizafang"]: Creation complete after 0s [id=none]
module.tf_airflow_users.random_password.password["peterdart"]: Creation complete after 0s [id=none]
module.tf_airflow_users.random_password.password["ridwanbejo"]: Creation complete after 0s [id=none]
module.tf_airflow_users.airflow_role.roles["custom-role-1"]: Creation complete after 0s [id=custom-role-1]
module.tf_airflow_users.airflow_role.roles["custom-role-2"]: Creation complete after 0s [id=custom-role-2]
module.tf_airflow_users.airflow_role.roles["custom-role-3"]: Creation complete after 0s [id=custom-role-3]
module.tf_airflow_users.airflow_user.users["elizafang"]: Creating...
module.tf_airflow_users.airflow_user.users["ridwanbejo"]: Creating...
module.tf_airflow_users.airflow_user.users["sakuramachi"]: Creating...
module.tf_airflow_users.airflow_user.users["michwang"]: Creating...
module.tf_airflow_users.airflow_user.users["peterdart"]: Creating...
module.tf_airflow_users.airflow_user.users["sakuramachi"]: Creation complete after 1s [id=sakuramachi]
module.tf_airflow_users.airflow_user.users["elizafang"]: Creation complete after 1s [id=elizafang]
module.tf_airflow_users.airflow_user.users["michwang"]: Creation complete after 1s [id=michwang]
module.tf_airflow_users.airflow_user.users["ridwanbejo"]: Creation complete after 1s [id=ridwanbejo]
module.tf_airflow_users.airflow_user.users["peterdart"]: Creation complete after 1s [id=peterdart]

Apply complete! Resources: 13 added, 0 changed, 0 destroyed.

Outputs:

airflow_users = {
  "elizafang" = "eliza.fangerbau@gmail.com"
  "michwang" = "michelle.wang@gmail.com"
  "peterdart" = "peter.dart@gmail.com"
  "ridwanbejo" = "ridwanbejo@gmail.com"
  "sakuramachi" = "sakura.machiya@gmail.com"
}
```

Now you can check the Airflow List Roles page and List User page to see the applied changes.

## C. Understanding tfvars scenarios

There are some scenarios that you could choose by using this module. For example:

1. create users without specifying custom role. For example you can choose `Viewer` role and assign it to users.

```
airflow_users = [
  {
    email      = "ridwanbejo@gmail.com"
    first_name = "Ridwan"
    last_name  = "Bejo"
    username   = "ridwanbejo"
    roles      = ["Viewer"]
  },
  {
    email      = "sakura.machiya@gmail.com"
    first_name = "Sakura"
    last_name  = "Machiya"
    username   = "sakuramachi"
    roles      = ["Viewer"]
  }
]
```

> In Airflow, there are some roles by default when you have Airflow fresh installation. Those roles are `Admin`, `Viewer`, `User`, `Op`, `Public`. I use `Viewer` because that was the default role which are provided by Airflow.

2. create users with custom role

```
airflow_users = [
  {
    email      = "peter.dart@gmail.com"
    first_name = "Peter"
    last_name  = "Dart"
    username   = "peterdart"
    roles      = ["custom-role-1"]
  },
  {
    email      = "eliza.fangerbau@gmail.com"
    first_name = "Eliza"
    last_name  = "Fangerbau"
    username   = "elizafang"
    roles      = ["custom-role-2"]
  }
]
```

3. create user with multiple roles

```
airflow_users = [
  {
    email      = "michelle.wang@gmail.com"
    first_name = "Michelle"
    last_name  = "Wang"
    username   = "michwang"
    roles      = ["custom-role-2", "custom-role-3"]
  }
]
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

If you find any issue, you can raise it here at our [Issue Tracker](https://github.com/ridwanbejo/terraform-airflow-user/issues)

If you have something that you want to merge to this repo, just raise [Pull Requests](https://github.com/ridwanbejo/terraform-airflow-user/pulls)

Ensure that you install all the tools from section D. for development purpose.
