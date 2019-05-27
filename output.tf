output "clientcertificate" {
  value = "${azurerm_kubernetes_cluster.AKS_CLS.kube_config.0.client_certificate}"
}

output "kubeconfig" {
  value = "${azurerm_kubernetes_cluster.AKS_CLS.kube_config_raw}"
}