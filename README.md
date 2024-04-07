## Required Versions

This project requires the following versions to ensure compatibility:

- **Terraform**: v1.7.0 or higher
- **AWS Provider for Terraform**: v5.40 or higher
- **AWS CLI**: v2.0.0 or higher

Please make sure that your local environment meets these requirements before proceeding with the setup and deployment.

## Coding Conventions

This project adheres to the Style Guide as outlined in the official Terraform documentation.

For more details, please refer to the [Terraform Style Guide](https://developer.hashicorp.com/terraform/language/style).

## Install AWS CLI

If you haven't already, install the AWS CLI:

```bash
$ brew install awscli
```

## AWS CLI Profile Configuration

This project uses the AWS CLI profile specified by the `profile_name` variable in `variables.tf`. By default, it is set to `"terraform-realworld-example"`. If this profile does not exist in your `~/.aws/credentials` file, Terraform will fall back to using the default AWS CLI profile.

To ensure that the correct profile is used, you can either:

1. Use the AWS CLI to create a new profile named `terraform-realworld-example`:

    ```bash
    $ aws configure --profile terraform-realworld-example
    ```

    Enter your AWS Access Key ID, Secret Access Key, and default region when prompted.

2. Or, override the default profile name by setting the `profile_name` variable when running Terraform commands:

    ```bash
    $ terraform apply -var="profile_name=your-profile-name"
    ```

Replace `your-profile-name` with the name of the AWS CLI profile you wish to use.

## Install Terraform

Install Terraform and manage multiple versions using `tfenv`:

```bash
$ brew install tfenv
$ tfenv install 1.7.5
$ tfenv use 1.7.5
```

Check the current version of Terraform:

```bash
$ terraform -version
Terraform v1.7.5
on darwin_arm64
```

## Initialize Terraform

Before applying any Terraform configuration, you need to initialize the Terraform environment. Navigate to the desired environment directory (e.g., prod or staging) and run:

```bash
$ terraform init
```

This will prepare the environment for Terraform operations.

## Apply Configuration

After initialization, you can apply the Terraform configuration to create or update resources:

```bash
$ terraform apply
```

Confirm the changes when prompted to proceed with the resource creation or modification.
