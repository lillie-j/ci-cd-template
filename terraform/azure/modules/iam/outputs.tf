output "client_id" {
  value = azuread_application.github_actions_app.id
  description = "Azure AD Application Client ID"
}

output "client_secret" {
  value = azuread_application_password.github_actions_sp_password.value
  description = "Azure AD Application Secret"
  sensitive = true
}

output "tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
  description = "Azure Tenant ID"
}

output "subscription_id" {
    value = data.azurerm_client_config.current.subscription_id
    description = "Azure Subscription ID"
}
