# ArgoCD with Keycloak (OIDC) Integration Guide

This guide provides step-by-step instructions for integrating ArgoCD with Keycloak using OpenID Connect (OIDC) for authentication. This setup allows leveraging Keycloak's powerful authentication mechanisms to manage access to ArgoCD.

## Prerequisites

- A running ArgoCD instance.
- A Keycloak server accessible to ArgoCD.

## Configuration

### Keycloak Setup

1. **Create a Realm**: Log into Keycloak and create a new realm named `argocd`.
2. **Create a Client**: Within the `argocd` realm, create a new client:
    - Client ID: `argocd`
    - Direct Access Grants Enabled: `true`
    - Valid Redirect URIs: `https://<argocd-uri>/auth/callback`
    - Protocol: `openid-connect`
    - Access Token Lifespan: `900` seconds
3. **Configure Groups**: Create a group named `ArgoCDAdmins` for ArgoCD administrators.
4. **Create Users**: Add users to your realm. Example for an admin user:
    - Username: `admin`
    - Credentials: Set a password.
    - Realm Roles: `offline_access`, `uma_authorization`
    - Client Roles: Assign `manage-users` and `view-users` under `realm-management`.

### ArgoCD Configuration

1. **Secret for OIDC ClientSecret**:
   Update the `argocd-secret` with the OIDC `clientSecret` from your Keycloak client configuration.

    ```yaml
    apiVersion: v1
    kind: Secret
    metadata:
      name: argocd-secret
      namespace: argocd
    type: Opaque
    data:
      oidc.keycloak.clientSecret: <Base64 encoded Client Secret>
    ```

2. **RBAC ConfigMap**:
   Define group permissions within ArgoCD. For example, granting `ArgoCDAdmins` admin permissions.

    ```yaml
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: argocd-rbac-cm
    data:
      policy.csv: |-
        g, ArgoCDAdmins, role:admin
    ```

3. **ArgoCD ConfigMap for OIDC**:
   Configure ArgoCD to use Keycloak as an OIDC provider.

    ```yaml
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: argocd-cm
      namespace: argocd
    data:
      url: https://<argocd-uri>
      oidc.config: |
        name: Keycloak
        issuer: https://<keycloak-uri>/realms/argocd
        clientID: argocd
        clientSecret: $oidc.keycloak.clientSecret
        requestedScopes: ["openid", "profile", "email"]
    ```

### Finalizing Setup

After applying the above configurations, ensure that your ArgoCD and Keycloak instances can communicate with each other. You might need to adjust firewalls or network policies depending on your environment.

## Verification

To verify the integration:

1. Access the ArgoCD UI.
2. You should be redirected to the Keycloak login page.
3. Log in using a user configured in the Keycloak `argocd` realm.
4. Upon successful authentication, you should be redirected back to ArgoCD and logged in.

## Troubleshooting

- Ensure all URLs are correctly configured, especially the Keycloak issuer and redirect URIs.
- Verify the `clientSecret` is correctly base64 encoded and matches the secret configured in Keycloak.
- Check network connectivity between ArgoCD and Keycloak.

## Contributing

This project is open source and contributions are welcome. Please submit issues or pull requests on our GitHub repository.

## License

This guide and accompanying configurations are provided under the MIT License.

