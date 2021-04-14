# AKS + k8s

References

- [azurerm_kubernetes_cluster](https://www.terraform.io/docs/providers/azurerm/r/kubernetes_cluster.html)

- [Kubernetes Provider](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs)

## Prerequisites

- Terraform 0.12.6 or later

- The Azure CLI Tool installed

## 1. Install the Azure CLI tool

- [Install the Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)

## 2. Authenticating to Azure using a Service Principal and a Client Secret

- [Service Principal Client Secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret)

Terraform supports a number of different methods for authenticating to Azure:

- Authenticating to Azure using the Azure CLI
- Authenticating to Azure using Managed Service Identity
- Authenticating to Azure using a Service Principal and a Client Certificate
- **Authenticating to Azure using a Service Principal and a Client Secret _(which is covered in this guide)_**

A Service Principal is an application within Azure Active Directory whose authentication tokens can be used as the ```client_id```, ```client_secret```, and ```tenant_id``` fields needed by Terraform (```subscription_id``` can be independently recovered from your Azure account details).

### 2.1 Authenticate using the Azure CLI

In your terminal, use the Azure CLI tool to setup your account permissions locally.

```az-cli
az login
```

Once logged in - it's possible to list the Subscriptions associated with the account via:

```az-cli
az account list
```

The output (similar to below) will display one or more Subscriptions - with the id field being the subscription_id field referenced above.

```az-cli
[
  {
    "cloudName": "AzureCloud",
    "id": "00000000-0000-0000-0000-000000000000",
    "isDefault": true,
    "name": "PAYG Subscription",
    "state": "Enabled",
    "tenantId": "00000000-0000-0000-0000-000000000000",
    "user": {
      "name": "user@example.com",
      "type": "user"
    }
  }
]
```

- ```id``` is the ```subscription_id``` defined above.

Should you have more than one Subscription, you can specify the Subscription to use via the following command:

```az-cli
az account set --subscription="SUBSCRIPTION_ID"
```

We can now create the Service Principal which will have permissions to manage resources in the specified Subscription using the following command:

```az-cli
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/SUBSCRIPTION_ID"
```

This command will output 5 values:

```az-cli
{
  "appId": "00000000-0000-0000-0000-000000000000",
  "displayName": "azure-cli-2017-06-05-10-41-15",
  "name": "http://azure-cli-2017-06-05-10-41-15",
  "password": "0000-0000-0000-0000-000000000000",
  "tenant": "00000000-0000-0000-0000-000000000000"
}
```

These values map to the Terraform variables like so:

- ```appId``` is the ```client_id``` defined above.
- ```password``` is the ```client_secret``` defined above.
- ```tenant``` is the ```tenant_id``` defined above.

## 3. Set Values

In the ```variable.tf``` file set values:

```tf
provider "azurerm" {
  features {}
  subscription_id = "00000000-0000-0000-0000-000000000000"
  client_id       = "00000000-0000-0000-0000-000000000000"
  client_secret   = "0000000000000000000000000000"
  tenant_id       = "00000000-0000-0000-0000-000000000000"
}
```

## 4. Run

Initialize a working directory that contains Terraform configuration files

```terraform
terraform init
```

Check if the execution plan matches your expectations without making any changes to actual resources or state.

```terraform
terraform plan
```

Apply the changes required to reach the desired state of the configuration

```terraform
terraform apply
```

````Terraform apply```` will create a new plan automatically and then prompt for approval to apply it

## 5. Connect to the cluster

[Reference](https://docs.microsoft.com/en-us/azure/aks/kubernetes-walkthrough#connect-to-the-cluster)

To manage a Kubernetes cluster, you use kubectl, the Kubernetes command-line client. If you use Azure Cloud Shell, kubectl is already installed. To install kubectl locally, use the az aks install-cli command:

```az-cli
az aks install-cli
```

To configure kubectl to connect to your Kubernetes cluster, use the az aks get-credentials command. This command downloads credentials and configures the Kubernetes CLI to use them.

```az-cli
az aks get-credentials --resource-group myResourceGroup --name myAKSCluster
```

## 6. Destroy

Destroy the Terraform-managed infrastructure. This will ask for confirmation before destroying.

```terraform
terraform destroy
```
