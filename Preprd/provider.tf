# Configure the Azure provider
terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}
# source = "hashicorp/azurerm" (required since Terraform 0.13 — the old style just said azurerm with no sourc
# Previously we deployed using Terraform 0.12, which did not require the source argument. The new style is required for Terraform 0.13 and later.

# The pessimistic constraint ~> — ~> 4.0 means ">= 4.0 but < 5.0"
# So you get patches and minor updates but never an unexpected major-version jump.
provider "azurerm" {
  features {}
}
# putting version inside the provider block,is the old deprecated style
# features {} stays (required) but is empty for now. It is a placeholder for future features that may be added to the provider.
# The old environment = "public" and skip_provider_registration = true are gone — public is the default so it's redundant, and skip_provider_registration is rarely needed.

# The provider "azurerm" { features {} } block — the actual configuration/credentials. 
# This belongs in the root only. Modules inherit it. If you put a provider block inside a module, you're generally doing it wrong (it causes problems, especially with for_each/count on modules and with destroy operations).

# The required_providers block (inside terraform {}) — this declares which provider and version the code needs. 
# The modern best practice is that each module should have its own required_providers, declaring what it depends on, but not a provider config block.
# It makes the module self-documenting and reusable — anyone using module can see exactly what it depends on without reading the root.
# If you skip it, the module still works (it inherits everything), but it's less portable. For a portfolio repo, adding it to each module is a nice