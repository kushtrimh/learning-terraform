# learning-terraform
Learning Terraform. Examples, guides, tips, and other information about Terraform to keep as reference for later use.

## Terraform

_The set of files used to describe infrastructure in Terraform is known as a Terraform configuration._
_Each Terraform configuration must be in its own working directory._

*Providers* are plugins that Terraform uses to manage resources.
*Resources* are physical or virtual components (e.g. EC2 instance), or logical resoruces (e.g. Heroku application). Each resource block contains arguments which are used to configure the resource.

Run ```terraform init``` when you create a new configuration or checkout out an existing one from version control, to initialize the directory.
This will download and install the providers defined in the configuration.

For formating use ```terraform fmt```, and for validation ```terraform validate```

Use ```terraform apply``` to applly the configuration.
_Apply_ will show the execution plan, which describes what actions Terraform will take in order to change the infrastructure to match the configuration.

Terraform normally loads all of the .tf and .tf.json files within a directory and expects each one to define a distinct set of configuration objects. If two files attempt to define the same object, Terraform returns an error.

* ```+``` resource will be created.
* ```-``` resource will be destroyed.
* ```-/+``` resource will be destroyed and recreated.

Terraform stores the IDs and properties of the resources it manages in ```terraform.tfstate```, so it can update or destroy those resources going forward.
This file contains sensitive information sometimes, so it must be stored securely and with restricted access to only the people that need to manage the infrastructure.
When Terraform creates a resource, it also gathers it's metadata from the provider and writes it in the state file.

Run ```terraform show``` to inspect the current state.

Run ```terraform state``` for advanced state management, ```terraform state list``` to list the resources in the project's state.

---

As you change Terraform configurations, Terraform builds an execution plan that only modifies what is necessary.

To destroy the infrastructure run ```terraform destroy```, which terminates the resources defined in the Terraform configuration.
Terraform will destroy the resources in order, to respect dependencies.

---

Terraform loads all files in the current directory ending in .tf, so you can name your configuration files however you choose.

We must apply the configuration, before we can use the _output_ values.

Run ```terraform output``` to query the outputs after _apply_.

---

Terraform is made of `Terraform core` and `Terraform plugins`

* Terraform Core reads the configuration and builds the resource dependency graph.
* Terraform Plugins (providers and provisioners) bridge Terraform Core and their respective target APIs. Terraform provider plugins implement resources via basic CRUD (create, read, update, and delete) APIs to communicate with third party services.

---

The `data` block retrieves additional information about a resource, which enables it to be referenced by another Terraform resource.

Input values make the configuration more flexible, by defining values that the end user can use to customize thhe configuration. They allow the user to assign different values to variables before the executing begins, and are not changed during `plan`, `apply`, or `destroy`.

Variables can be kept anywhere in the configuration files, but it is recommended to put them at `variables.tf` file.

```hcl
variable "aws_region" {
    description = "AWS region"
    type = string
    default = "eu-central-1"
}
```

Variables must be literal values, they cannot be computed.

Refer using `var`

```
provider aws {
    region = var.aws_region
}
```

---

Use `depends_on` meta-argument to handle hidden resource or modules dependencies, that Terraform can not infer automatically. Specifying this meta-argument is neccessary only when a resource or module relies on some other resource's behavior but does not access any of its data in  its arguments.

```HCL
resource "aws_instance" "example" {
  ami           = "some-ami"
  instance_type = "t2.nano"

  depends_on = [
    aws_iam_role_policy.example,
  ]
}
```

Expressions not allowed on `depends_on`. Use it as a last restort, and always document its usage.

---