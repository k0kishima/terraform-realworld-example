## Required Versions

This project requires the following versions to ensure compatibility:

- **Terraform**: v1.7.0 or higher
- **AWS Provider for Terraform**: v5.40 or higher
- **tfenv** (optional): Recommended for managing multiple Terraform versions

Please make sure that your local environment meets these requirements before proceeding with the setup and deployment.

## Coding Conventions

This project adheres to the Style Guide as outlined in the official Terraform documentation.

For more details, please refer to the [Terraform Style Guide](https://developer.hashicorp.com/terraform/language/style).


## Install Terraform

Install Terraform using the following command:

```bash
 $ brew install tfenv
```

Check if installation was successful.

```bash
 $ tfenv -v
```

Install and use a specific version.

```
$ tfenv install 1.7.5
$ tfenv use 1.7.5
```

Check the current version.

```
$ terraform -version
Terraform v1.7.5
on darwin_arm64
```
