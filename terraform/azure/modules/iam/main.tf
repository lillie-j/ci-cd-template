data "azurerm_client_config" "current" {}

resource "azuread_application" "github_actions_app" {
    display_name = "github-actions-acr-app"
}

resource "azuread_service_principal" "github_actions_sp" {
    client_id = azuread_application.github_actions_app.id
}

resource "azuread_application_password" "github_actions_sp_password" {
    application_id = azuread_application.github_actions_app.id
    display_name = "github-actions-sp-secret"
}


locals {
    acr_roles = ["AcrPush", "AcrPull"]
}


resource "azurerm_role_assignment" "github_actions_acr_push" {
    for_each = toset(local.acr_roles)

    scope = var.acr_id
    role_definition_name = each.key
    principal_id = azuread_service_principal.github_actions_sp.id
}
