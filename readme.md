# Terraform Project for GitLab Runner EC2 Instance

This Terraform project provisions an AWS EC2 instance designed to serve as a GitLab Runner for running CI/CD pipelines. Alongside the runner, it sets up essential networking infrastructure and IAM roles and policies necessary for the runner's operation. The infrastructure includes a VPC, an Internet Gateway (IGW), a public subnet, a route table, and IAM roles/policies for accessing S3 Buckets for Terraform remote state, DynamoDB for state locking, and necessary permissions for EC2 and VPC management.

## Prerequisites

- Terraform installed on your local machine.
- AWS CLI installed and configured with at least one profile.
- GitLab account and a repository to run the CI/CD pipelines.

## Installation & Setup

### Clone the Repository

First, clone this repository to your local machine using:

```bash
git clone https://github.com/HarelSultan/gitlab_runner.git
cd gitlab_runner
```

### Initialize Terraform

Run the following command to initialize a new or existing Terraform working directory:

```bash
terraform init
```

This command will install the necessary Terraform providers and modules.

### Create a Terraform Variable File

Modify the file named `terraform-examples.tfvars` and specify the necessary variables according to your AWS setup and project needs.

### Plan the Deployment

Execute the following command to generate and show an execution plan:

```bash
terraform plan -var-file="terraform-examples.tfvars"
```

### Apply the Configuration

Apply the changes required to reach the desired state of the configuration:

```bash
terraform apply -var-file="terraform-examples.tfvars"
```

### Register the GitLab Runner

After the EC2 instance is provisioned, manually register the GitLab Runner with your GitLab instance using the following command. Replace `your_generated_token` with your actual registration token from GitLab:

```bash
sudo gitlab-runner register --url https://gitlab.com --token your_generated_token
```

## Project Structure

- **Networking Module**: Sets up the VPC, IGW, subnet, and route table.
- **IAM Module**: Configures IAM roles, policies, and an instance profile for the EC2 instance.
- **EC2 Module**: Provisions an EC2 instance installed with Terraform, Terragrunt, and the GitLab Runner.

## Manual Steps

The only manual step required is the registration of the GitLab Runner with GitLab using the generated token, as automated runner registration poses security risks and complications.

## Cleanup

To destroy the Terraform-managed infrastructure, use:

```bash
terraform destroy -var-file="terraform-examples.tfvars"
```

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue for any bugs or improvements.

## License


## Important

Please note that some of the configurations, such as the policies attached are AWS managed and allowing full access to some resources, you should modify the policies granted to your specific project needs, following least-privileged principle.