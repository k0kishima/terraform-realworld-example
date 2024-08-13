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

## SSM Parameter Store Configuration

Before deploying the infrastructure, you need to store the database credentials in AWS SSM Parameter Store for both the staging and production environments. This ensures that Terraform can securely retrieve these credentials during the deployment process.

### Storing Credentials for Production and Staging Environment

Run the following commands to store the database username and password for the staging environment:

```bash
$ aws ssm put-parameter --name "/realworld-example/staging/db/username" --value "root" --type "String"
$ aws ssm put-parameter --name "/realworld-example/staging/db/password" --value "your_staging_db_password" --type "SecureString"
$ aws ssm put-parameter --name "/realworld-example/prod/db/username" --value "root" --type "String"
$ aws ssm put-parameter --name "/realworld-example/prod/db/password" --value "your_staging_db_password" --type "SecureString"
```

Replace `your_staging_db_password` and `your_prod_db_password` with the actual credentials for your databases.

The SSM parameters must be created before running `terraform apply` to avoid errors during the deployment process.

Use the same AWS CLI profile for both creating the SSM parameters and running Terraform commands to ensure consistency.

#### Note on Database Username

In this sample application, the database username is set to `root` for simplicity. Normally, it is recommended to create a specific MySQL user with the minimum required privileges for security purposes. However, to reduce setup complexity and since this is a sample application, we are using the default `root` user.

If you prefer to follow best practices and use a different MySQL user with restricted privileges, make sure to create that user in your MySQL instance and update the corresponding SSM Parameter Store entries accordingly.

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

## Optional: Using pre-commit for Code Quality Checks

This project supports [pre-commit](https://pre-commit.com/) for automated code quality checks before each commit. Using `pre-commit` is optional, and commits can be made without it. However, it is recommended to use `pre-commit` to maintain code quality.

### Prerequisites

- **Python**: `pre-commit` requires a Python environment. Make sure Python is installed on your system.

### Installing pre-commit

If you choose to use `pre-commit`, install it using:

```bash
$ pip install pre-commit
```

### Setting up pre-commit

To set up `pre-commit` in your local repository, navigate to the project's root directory and run:

```bash
$ pre-commit install
```

This command installs the pre-commit hooks specified in the .pre-commit-config.yaml file.

### Running pre-commit

`pre-commit` will automatically run when you commit your changes. To manually run all pre-commit hooks on all files, use:

```bash
$ pre-commit run --all-files
```

To update the hooks to the latest versions, run:

```bash
$ pre-commit autoupdate
```

### Skipping pre-commit

If you need to bypass the pre-commit checks for a specific commit, you can use:

```bash
$ git commit --no-verify
```
