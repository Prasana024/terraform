#Please mention the created Service principal(azure cli) output details below in provider section and under service principal section

provider "azurerm"{
  subscription_id = ""
  client_id = ""
  client_secret = ""
  tenant_id = ""
}

resource "azurerm_resource_group" "test" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
}

resource "azurerm_kubernetes_cluster" "AKS_CLS" {
  name                = "${var.resourceName}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"
  dns_prefix          = "${var.dnsprefix}"

agent_pool_profile {
    name            = "${var.agentpoolprofile}"
    count           = "${var.agentcount}"
    vm_size         = "${var.agentVMSize}"
    os_type         = "${var.agentostype}"
    os_disk_size_gb = "${var.os_disk_size_gb}"
  }

   service_principal {
    client_id = ""
    client_secret = ""
  } 

tags = {
    Environment = "Production"
    owner = "prasana"
  }
}


