output "web_app_instance" {
  value       = azurerm_windows_web_app.app-PlanePal-dev-northeurope-00.identity[0]
}
output "web_app_id" {
  value       = azurerm_windows_web_app.app-PlanePal-dev-northeurope-00.id
}