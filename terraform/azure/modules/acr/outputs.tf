output "acr_login_server" {
    description = "Login Server of ACR Repo"
    value = azurerm_container_registry.ci_cd_repo.login_server
}

output "acr_admin_username" {
    description = "ACR Repo Admin Username"
    value = azurerm_container_registry.ci_cd_repo.admin_username
    sensitive = true
}

output "acr_admin_password" {
    description = "ACR Repo Admin Password"
    value = azurerm_container_registry.ci_cd_repo.admin_password
    sensitive = true
}

output "acr_resource_id" {
    description = "Azure Resource ID of ACR Registry"
    value = azurerm_container_registry.ci_cd_repo.id
}
