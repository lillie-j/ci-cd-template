This folder contains Terraform configurations for provisioning infrastructure resources.

## Guidelines

### 1. Format Code

Before committing any changes, run:

`terraform fmt -recursive`

### 2. Update Docs

If you've modified variables, outputs, or modules, regenerate documentation in target folder using:

```
cd <target-folder>
terraform-docs markdown table . > README.md
```

### 3. Deploy Resources

To deploy resources, change into your target directory (AWS or Azure) and dry run any changes before applying

```
cd <target-directory>
terraform plan
terraform apply
```