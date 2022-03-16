# Best practices

## Module naming

terraform-PROVIDER-NAME eg. terraform-aws-ec2

## Release Tags

Must be a semantic version. For example v1.0.4. The v prefix is mandatory.

## Repository description

This is mandatory within the README.md and can be a simple sentence that explains the module.

## Readme

README. The root module and any nested modules should have README files. This file should be named README or README.md. The latter will be treated as markdown.

## License file

The license under which this module is available. If you are publishing a module publicly, many organizations will not adopt a module unless a clear license is present.
We recommend always having a license file, even if it is not an open source license.

## Files

### MODULENAME

- README.md
- main.tf
- variables.tf
- outputs.tf

For a simple module, this may be where all the resources are created.
For a complex module, resource creation may be split into multiple files but any nested module calls should be in the main file.
variables.tf and outputs.tf should contain the declarations for variables and outputs, respectively.

## Variables and Outputs

Must have subscriptions and type declarations.

## Nested modules

Nested modules should exist under the modules/ subdirectory. Any nested module with a README.md is considered usable by an external user. If a README.md doesn't exist, it is considered for internal use only.

## Examples

Examples of using the module should exist under the examples/subdirectory at the root of the repository. Each example may have a README.md to explain the goal and usage of the example.

## Providers

Although provider configurations are shared between modules, each module must declare its own provider requirements, so that Terraform can ensure that there is a single version of the provider that is
compatible with all modules in the configuration and to specify the source address that serves as the global (module-agnostic) identifier for a provider.

terraform {
required_providers {
aws = {
source = "hashicorp/aws"
version = ">= 2.7.0"
configuration_aliases = [ aws.alternate ]
}
}
}

When child modules each need a different configuration of a particular provider, or where the child module requires a different provider configuration than its parent,
you can use the providers argument within a module block to explicitly define which provider configurations are available to the child module. For example:

### The default "aws" configuration is used for AWS resources in the root

### module where no explicit provider instance is selected

provider "aws" {
region = "us-west-1"
}

### An alternate configuration is also defined for a different

### region, using the alias "usw2"

provider "aws" {
alias = "usw2"
region = "us-west-2"
}

### An example child module is instantiated with the alternate configuration

### so any AWS resources it defines will use the us-west-2 region

module "example" {
source = "./example"
providers = {
aws = aws.usw2
}
}

## Formatting and linting

Use terraform fmt to reformat your configuration in the standard style.
