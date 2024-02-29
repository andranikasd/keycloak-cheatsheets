# Terraform Module for ArgoCD Realm Creation in Keycloak

This Terraform module automates the setup of a Keycloak realm specifically designed for ArgoCD, facilitating secure and streamlined authentication and authorization mechanisms for your ArgoCD instances through Keycloak.

## Requirements

No specific requirements are needed for this module beyond having Terraform installed and access to a Keycloak server.

## Providers

| Name | Version |
|------|---------|
| [keycloak](#provider_keycloak) | n/a |

This module utilizes the Keycloak provider for Terraform, which must be properly configured to interact with your Keycloak instance.

## Modules

No additional Terraform modules are used by this module.

## Resources

The module provisions the following resources:

| Name | Type |
|------|------|
| [keycloak_realm.argocd_realm](https://registry.terraform.io/providers/hashicorp/keycloak/latest/docs/resources/realm) | resource |
| [keycloak_openid_client.argocd_client](https://registry.terraform.io/providers/hashicorp/keycloak/latest/docs/resources/openid_client) | resource |

These resources are essential for integrating ArgoCD with Keycloak, ensuring a secure authentication flow.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `keycloak_server_url` | The URL of the Keycloak server. | `string` | n/a | yes |
| `keycloak_admin_user` | The admin username for Keycloak. | `string` | n/a | yes |
| `keycloak_admin_password` | The admin password for Keycloak. | `string` | n/a | yes |
| `argocd_realm_name` | The name of the realm to be created for ArgoCD. | `string` | `"argocd"` | no |
| `argocd_client_id` | The client ID for ArgoCD. | `string` | `"argocd"` | no |
| `argocd_client_secret` | The client secret for ArgoCD. | `string` | n/a | yes |
| `argocd_redirect_uris` | The redirect URIs for ArgoCD. | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| `argocd_realm_id` | The ID of the created ArgoCD realm. |
| `argocd_client_id` | The client ID for the ArgoCD client. |

## Usage

```hcl
module "argocd_keycloak" {
  source = "path/to/this/module"

  keycloak_server_url       = "https://your-keycloak-server"
  keycloak_admin_user       = "keycloak-admin"
  keycloak_admin_password   = "your-admin-password"
  argocd_client_secret      = "your-client-secret"
  argocd_redirect_uris      = ["https://your-argocd-server/auth/callback"]
}
```

Replace the placeholder values with your actual Keycloak server URL, admin credentials, client secret, and ArgoCD redirect URI. Then, initialize Terraform with terraform init and apply the configuration with `terraform apply`.

## Contributing

Contributions are welcome! If you would like to contribute, please fork the repository, make your changes, and submit a pull request.

## License

This module is provided under the terms of the GPL license.