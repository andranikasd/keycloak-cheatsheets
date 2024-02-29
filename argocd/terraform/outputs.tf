output "argocd_realm_id" {
  value = keycloak_realm.argocd_realm.id
  description = "The ID of the created ArgoCD realm"
}

output "argocd_client_id" {
  value = keycloak_openid_client.argocd_client.client_id
  description = "The client ID for the ArgoCD client"
}

# Add other outputs as needed
