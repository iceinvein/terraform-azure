# Terraform Azure (CosmosDB and App service)

This creates a free tier cosmos db and uses the connection string to provision app service that uses a pre defined container registry where an image has been pushed.

## Test run

Create `test.tfvars` file and suply the required values for variables in `variables.tf`

## Initialize

`terraform init`

## Plan

`terraform plan --out "plan.out" -var-file="test.tfvars"`

## Apply

`terraform apply "plan.out"`

## Destroy

`terraform destroy -var-file="test.tfvars" -auto-approve`
