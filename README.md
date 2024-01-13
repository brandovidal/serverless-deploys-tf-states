<h1 align="center">
  🪐 Terraform CI/CD - terragrunt
</h1>

## Requirements

- Terraform v.1.6.6+
- Terragrunt v0.52.0+
- AWS account (free tier)

## Steps

- Init project
  Locate in `cloud/` folder

```bash
terragrunt init
```

- Run plan
  Locate in some service, for exmaple: `services/backoffice/` folder

```bash
terragrunt plan
```

- Apply
  Locate in some service, for exmaple: `services/backoffice/` folder

```bash
terragrunt apply
```
