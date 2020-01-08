variable "resourceName" {
  default = "AzureKubernetes"
  description = "The name of the kubernetes cluster name"
}

variable "resource_group_name" {
  default = "CUS-MSP-DEVTST-KUBERNTSCluster"
  description = "name of the resource group"
}

variable "location" {
  default = "East US"
  description = "Resouce Location"
}

variable "dnsprefix" {
    default = "AzureKubernetes-dns"
    description = "Optional DNS prefix to use with hosted Kubernetes API server FQDN"
}

variable "agentpoolprofile" {
    default = "testprof"
    description = "Name of the agent profile"
  
}

variable "agentcount" {
    default = "3"
    description = "Name of the agent count"
    }

variable "agentVMSize" {
    default = "Standard_DS2_v2"
    description = "count of agentvmsize"
}

variable "agentostype" {
    default = "Linux"
}

variable "os_disk_size_gb" {
    default = "30"
}




