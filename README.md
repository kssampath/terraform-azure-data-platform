# Terraform Modules

Infrastructure-as-code for provisioning the **Enterprise Data Hub (EDH)** platform on **Microsoft Azure**. This repository holds reusable Terraform modules and the environment configurations that compose them.

---

## What's here

Each top-level folder is a self-contained **environment** — a root Terraform configuration that wires together the service modules under its own `modules/` directory.

| Environment | Region | Purpose | Docs |
|---|---|---|---|
| [`Preprd/`](./Preprd) | East US 2 | Pre-production EDH stack (resource groups, networking, Databricks, storage, analytics) | [Preprd README](./Preprd/README.md) |

> Additional environments (e.g. `Dev/`, `Prod/`) would each live in their own top-level folder following the same structure.

---

## Repository structure

```
Terraform-modules/
├── README.md              ← you are here (repo overview)
├── .gitignore
└── Preprd/                ← pre-prod environment
    ├── README.md          ← detailed setup, architecture, and usage
    ├── main.tf            ← composes the service modules
    ├── variables.tf
    ├── provider.tf
    ├── demo.auto.tfvars
    ├── docs/              ← architecture diagram + diagram-as-code
    └── modules/           ← reusable per-service modules
```

Every environment follows the same convention: a root configuration (`main.tf`, `variables.tf`, `provider.tf`, `*.tfvars`) plus a `modules/` folder of single-purpose building blocks (resource group, virtual network, storage, Databricks, etc.).

---

## Technology

- **Terraform** `>= 0.12`
- **Azure provider** (`azurerm`) `>= 2.0.0`
- Target cloud: **Microsoft Azure** (public)

---

## Getting started

Work happens inside an environment folder, not at the repo root. To stand up the pre-prod environment:

```bash
cd Preprd
terraform init
terraform plan
terraform apply
```

Full prerequisites, authentication, configuration, and the architecture diagram are documented in the **[Preprd README](./Preprd/README.md)**. Start there.

---

## Conventions

- **Naming:** resources follow the pattern `<type>-ads-eus2-edh-<env>-<service>-<nnn>` (e.g. `rg-ads-eus2-edh-preprd-dbx-005`).
- **Tagging:** every resource carries a common governance tag set — `AppId`, `environment`, `DataClassification`, `Role`, `SupportGroup`.
- **Modules:** each module exposes `main.tf`, `variable(s).tf`, and (where relevant) `output(s).tf`.

---

## Security

- **Do not commit secrets.** Credentials belong in Azure Key Vault or `TF_VAR_*` environment variables, never in `.tfvars`.
- **Do not commit state.** `*.tfstate` files can contain secrets and are excluded via `.gitignore`; use a remote backend for shared work.

See the [Preprd README](./Preprd/README.md#security) for environment-specific security notes.

---

## Contributing

1. Create a branch for your change.
2. Run `terraform fmt` and `terraform validate` before committing.
3. Run `terraform plan` and include the summary in your pull request.
4. Open a PR against the default branch for review.

---

## License

Add your license here (e.g. MIT). No license file is currently present in the repository.
