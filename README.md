🚧 This repository is incomplete

**🚨 Important Note: It is strongly recommended to run `terraform destroy` when the resource is no longer needed or once the necessary checks have been completed.**

## Project Overview

This is an example of an IaC implementation for [Real World](https://github.com/gothinkster/realworld).  
Terraform is used for the IaC implementation and AWS for the public cloud.

Special notes are as follows:

- No SSL this time.
  - Because I can't use ACM without a domain name.
- Remote backend not supported this time
- This was not necessary in this case because we are targeting public repositories, but if you are targeting private repositories, you can use [Github personal tokens](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#personal-access-token-classic-%E3%81%AE%E4%BD%9C%E6%88%90)
  - Use “fine-grained personal access tokens” that can be restricted to specific repositories
- Minimum Authority Considerations
  - In general, permissions should be set to minimal, but this is an experimental repository, so they are set roughly

## Required Versions

This project requires the following versions to ensure compatibility:

- **Terraform**: v1.8.0 or higher
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

To configure the AWS CLI profile, follow these steps:

1. Use the AWS CLI to set the profile

    ```bash
    $ aws configure --profile <profile-name>
    ```

    Replace `<profile-name>` with your desired profile name.

2. Or, Set the Environment Variable

    ```bash
    $ export AWS_PROFILE=<profile-name>
    ```

The profile must have permissions to generate IAM.

## SSM Parameter Store Configuration

Before deploying the infrastructure, you need to store the database credentials in AWS SSM Parameter Store for both the staging and production environments.  
This ensures that Terraform can securely retrieve these credentials during the deployment process.

### Storing Credentials for Production and Staging Environment

Run the following commands to store the database username and password for the staging environment:

```bash
$ aws ssm put-parameter --name "/realworld-example/staging/db/username" --value "root" --type "String"
$ aws ssm put-parameter --name "/realworld-example/staging/db/password" --value <your_staging_db_password> --type "SecureString"
$ aws ssm put-parameter --name "/realworld-example/prod/db/username" --value "root" --type "String"
$ aws ssm put-parameter --name "/realworld-example/prod/db/password" --value <your_prod_db_password> --type "SecureString"
```

Replace `<your_staging_db_password>` and `<your_prod_db_password>` with the actual credentials for your databases.

The SSM parameters must be created before running `terraform apply` to avoid errors during the deployment process.

Use the same AWS CLI profile for both creating the SSM parameters and running Terraform commands to ensure consistency.

#### Note on Database Username

In this sample application, the database username is set to `root` for simplicity. Normally, it is recommended to create a specific MySQL user with the minimum required privileges for security purposes. However, to reduce setup complexity and since this is a sample application, we are using the default `root` user.

If you prefer to follow best practices and use a different MySQL user with restricted privileges, make sure to create that user in your MySQL instance and update the corresponding SSM Parameter Store entries accordingly.

## Install Terraform

Install Terraform and manage multiple versions using `tfenv`:

```bash
$ brew install tfenv
$ tfenv install 1.8.5
$ tfenv use 1.8.5
```

Check the current version of Terraform:

```bash
$ terraform -version
Terraform v1.8.5
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
$ cd staging  # or prod
$ terraform apply
```

Confirm the changes when prompted to proceed with the resource creation or modification.

**🚨 Important Note: It is strongly recommended to run `terraform destroy` when the resource is no longer needed or once the necessary checks have been completed.**

## Deployment

### Deployment Strategy

In this project, I use a hybrid approach for managing infrastructure and application deployments:

- **Infrastructure as Code (IaC)**: We use Terraform to define and provision all necessary AWS resources, including ECS clusters, load balancers, security groups, and other infrastructure components. This ensures that our environment is consistent, version-controlled, and easily reproducible.

- **Application Deployment**: While the infrastructure is managed through IaC, the deployment of Docker images (for both frontend and backend services) to the ECS containers is handled separately via GitHub Actions. This CI/CD pipeline automates the build, push, and deployment of Docker images to the ECS services, allowing for seamless updates to the application without requiring changes to the underlying infrastructure.

This separation of concerns allows for more flexible and efficient management of both infrastructure and application code. Infrastructure changes are managed through Terraform, while application updates are deployed through GitHub Actions, providing a streamlined and automated deployment process.

### How to Deploy

Fork each of the following two repositories (frontend and backend).

- [k0kishima/nuxt3-realworld-example-app](https://github.com/k0kishima/nuxt3-realworld-example-app)
- [k0kishima/golang-realworld-example-app](https://github.com/k0kishima/golang-realworld-example-app)

Set up the following Actions secrets

- Required for both repositories
  - `AWS_ACCOUNT_ID`.
  - `AWS_REGION`.
- Required for frontend only.
  - `API_BASE_URL`.
- Required for backend only.
  - `DB_USER`
  - `DB_PASSWORD`
  - `DB_HOST`
  - `DB_NAME`
  - `JWT_SECRET`
  - `ALLOWED_ORIGINS`

The `DB_HOST`, etc. should be the value you see in the output after you run `terraform apply`.

🚧 TODO: Here is how to inject the repository name as an argument

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
