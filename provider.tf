# Initial trigger:  Any committed changes to the main branch of tfinfra-x repo 
# ---- these trigger a Webhook to Terraform Cloud
# TFC generates a JSON Web Token (JWT) signed with its own private cryptographic key.
# TFC stamps specific data (claims) inside this token:
# ---- sub (Subject): "I am workspace 'tfinfra-x', run ID 'run-xyz'."
# ---- terraform_organization_id: "I belong to TFC org '{org-id}'."
# ---- terraform_workspace_name: "tfinfra-x".
# TFC sends the OIDC Token to the Google Security Token Service (STS) API. 
# ---- TFC uses configured workspace variables to target the GCP identity hub project WIF pool and provider address.
# GCP takes the data from the OIDC Token (Assertions) and maps them to Google-internal attributes 
# ---- these attributes are configured in GCP in the mapping rules section of the WIF provider, specifically:
# ---- assertion.terraform_workspace_name == attribute.terraform_workspace_name
# GCP issues a Federated Token to TFC. 
# ---- This is a temporary Google-specific credential that represents the external user
# Now holding the Federated Token, TFC calls the GCP IAM Credentials API. 
# ---- TFC says: "I have this Federated Token. I would like to assume the role of the spoke project service account 
# ---- the specific spoke SA value is configured in the TFC workspace variable "TFC_GCP_RUN_SERVICE_ACCOUNT_EMAIL"
# GCP checks the spoke SA IAM bindings.  It sees a configured rule:
# ---- "Allow access to roles/iam.workloadIdentityUser IF the principal is .../attribute.terraform_workspace_name/tfinfra-x.
# GCP issues a short-lived Service Account Access Token (valid for 1 hour).
# ---- The Terraform Google Provider uses that access token to call Google APIs (Compute Engine, Storage, etc.) within the spoke project.

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = "tltestlab-project3"
  # TFC automatically handles the auth using the Spoke SA now.
}