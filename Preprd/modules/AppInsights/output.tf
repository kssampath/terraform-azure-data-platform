# output "instrumentation_key" {
#   value = azurerm_application_insights.azure-appin.instrumentation_key
# }


# Connection string is the modern telemetry identifier (instrumentation key is legacy).
output "connection_string" {
  description = "Application Insights connection string (used by apps to send telemetry)"
  value       = azurerm_application_insights.azure-appin.connection_string
  sensitive   = true
}

output "app_id" {
  description = "Application Insights app ID"
  value       = azurerm_application_insights.azure-appin.app_id
}