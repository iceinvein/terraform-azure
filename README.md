# Terraform Azure (CosmosDB and App service)

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
