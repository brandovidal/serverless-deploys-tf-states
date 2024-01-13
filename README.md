<h1 align="center">
  🪐 Terraform CI/CD - terragrunt
</h1>

## Requirements

- Terraform v.1.6.6+
- Terragrunt v0.52.0+
- AWS account (free tier)

## Steps

- Configure you aws profile with your credentials

```bash
aws configure terraform-user
```

- Init project, ubicate in `cloud/` folder

```bash
terragrunt init
```

- Run plan, ubicate in some service, for exmaple: `services/backoffice/` folder

```bash
terragrunt plan
```

- Apply project, ubicate in some service, for exmaple: `services/backoffice/` folder

```bash
terragrunt apply
```
