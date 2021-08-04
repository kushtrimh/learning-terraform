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


```+``` resource will be created
```-``` resource will be destroyed
```-/+``` resource will be destroyed and recreated

Terraform stores the IDs and properties of the resources it manages in ```terraform.tfstate```, so it can update or destroy those resources going forward.
This file contains sensitive information sometimes, so it must be stored securely and with restricted access to only the people that need to manage the infrastructure.
When Terraform creates a resource, it also gathers it's metadata from the provider and writes it in the state file.

Run ```terraform show``` to inspect the current state.

Run ```terraform state``` for advanced state management, ```terraform state list``` to list the resources in the project's state.

---

As you change Terraform configurations, Terraform builds an execution plan that only modifies what is necessary

To destroy the infrastructure run ```terraform destroy```, which terminates the resources defined in the Terraform configuration.
Terraform will destroy the resources in order, to respect dependencies.