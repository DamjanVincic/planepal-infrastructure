output "tenant_id" {
  value = azurerm_windows_web_app.app-PlanePal-dev-northeurope-00.identity[0].tenant_id
}
output "object_id" {
  value = azurerm_windows_web_app.app-PlanePal-dev-northeurope-00.identity[0].principal_id
}
output "web_app_id" {
  value = azurerm_windows_web_app.app-PlanePal-dev-northeurope-00.id
}