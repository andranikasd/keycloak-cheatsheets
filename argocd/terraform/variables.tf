variable "keycloak_server_url" {
  description = "URL for the Keycloak server"
}

variable "keycloak_admin_user" {
  description = "Admin username for Keycloak"
}

variable "keycloak_admin_password" {
  description = "Admin password for Keycloak"
}

variable "argocd_realm_name" {
  description = "Name of the realm to be created for ArgoCD"
  default     = "argocd"
}

variable "argocd_client_id" {
  description = "Client ID for ArgoCD"
  default     = "argocd"
}

variable "argocd_client_secret" {
  description = "Client secret for ArgoCD"
}

variable "argocd_redirect_uris" {
  description = "Redirect URIs for ArgoCD"
  type        = list(string)
}

# Add other variables as needed
