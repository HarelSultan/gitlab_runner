#!/bin/bash
# Terraform
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform

# Terragrunt
wget -q -O terragrunt "https://github.com/gruntwork-io/terragrunt/releases/download/v0.56.2/terragrunt_linux_amd64"
sudo mv terragrunt /usr/local/bin/terragrunt
sudo chmod +x /usr/local/bin/terragrunt

# GitLab Runner
sudo curl -L --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64
sudo chmod +x /usr/local/bin/gitlab-runner
sudo useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash
sudo gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
sudo gitlab-runner start