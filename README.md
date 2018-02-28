# cheapgpu
Terraform script to provision AWS EC2 Spot Instances with [Deep Learning AMI (Amazon Linux)](https://aws.amazon.com/marketplace/pp/B077GF11NF) latest version.

# Requirements
+ [Terraform](https://www.terraform.io/)
+ [AWS cli](https://aws.amazon.com/cli)
+ Default Terraform backend state must be either customized or disabled 

# Example
```
# Provision
aws configure
terraform init
terraform apply \
    -var 'spot_price=1.1' \
    -var 'instance_type=p3.2xlarge' \
    -var 'region=us-east-1' \
    -var 'key_name=terraform'

# Cleanup
terraform destroy
```