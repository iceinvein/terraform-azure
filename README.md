# Terraform Azure (CosmosDB and App service)

## Test run

Create test.tfvars file and suply the required values

```text
client_secret = ""
subscription_id = ""
client_id = ""
tenant_id = ""
location = ""
cors_origin = ""
root_password = ""
container_registry_resource_group = ""
container_registry_name = ""
```

## Initialize

`terraform init`

## Plan

`terraform plan --out "plan.out" -var-file="test.tfvars"`

## Apply

`terraform apply "plan.out"`

## Destroy

`terraform destroy -var-file="test.tfvars" -auto-approve`
