provider "keycloak" {
  client_id     = var.keycloak_admin_user
  client_secret = var.keycloak_admin_password
  realm         = "master" # Admin operations are typically performed in the master realm
  url           = var.keycloak_server_url
}

resource "keycloak_realm" "argocd_realm" {
  realm   = var.argocd_realm_name
  enabled = true
}

resource "keycloak_openid_client" "argocd_client" {
  realm_id                 = keycloak_realm.argocd_realm.id
  client_id                = var.argocd_client_id
  name                     = "ArgoCD"
  enabled                  = true
  client_secret            = var.argocd_client_secret
  access_type              = "CONFIDENTIAL"
  direct_access_grants_enabled = true
  standard_flow_enabled    = true
  implicit_flow_enabled    = false
  redirect_uris            = var.argocd_redirect_uris
}

# Add resources for users, groups, etc., as needed

