<h1 align="center">
  🪐 Terraform CI/CD - Serverless Deploys TF States
</h1>

## Requirements

- Terraform v.1.6.6+
- AWS account (free tier)

## Steps

- Configure you aws profile with your credentials

```bash
aws configure terraform-user
```

- Init project, ubicate in `cloud/` folder

```bash
terraform init
```

- Run plan, ubicate in some service, for exmaple: `services/backoffice/` folder

```bash
terraform plan
```

- Apply project, ubicate in some service, for exmaple: `services/backoffice/` folder

```bash
terraform apply
```
