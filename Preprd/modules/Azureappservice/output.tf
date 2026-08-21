output "app_service_ids" {
  description = "Map of logical name to web app ID"
  value       = { for k, app in azurerm_linux_web_app.appservice : k => app.id }
}

output "sql_server_id" {
  description = "ID of the SQL server"
  value       = azurerm_mssql_server.sql_server1.id
}