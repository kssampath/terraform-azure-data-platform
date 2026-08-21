output "sql_server_id" {
  description = "ID of the Synapse SQL server"
  value       = azurerm_mssql_server.sql_server.id
}

output "sql_dw_id" {
  description = "ID of the Synapse SQL data warehouse"
  value       = azurerm_mssql_database.sql_dw.id
}