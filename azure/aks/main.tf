# Create a resource group
resource "azurerm_resource_group" "aks_resource_group" {
  name     = "${var.project.name}-dev"
  location = var.project.location
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "${var.project.name}-k8s"
  location            = azurerm_resource_group.aks_resource_group.location
  resource_group_name = azurerm_resource_group.aks_resource_group.name
  dns_prefix          = "${var.project.name}-k8s"

  default_node_pool {
    name            = "default"
    node_count      = var.node.count
    vm_size         = var.node.machine_type
    os_disk_size_gb = var.node.disk_size_gb
  }
  
  identity {
    type = "SystemAssigned"
  }
}