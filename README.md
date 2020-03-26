# terraform-azure-k8s

Terraform Azure AKS

# TL;DR

- Create Blob Storage on Azure (for tfstate file);
- Create a Container on that Blob Storage (name=tfstate);
- Get your storage account name and access key;
- Execute the following commands on your shell:

```bash
terraform init -backend-config="storage_account_name=<YourAzureStorageAccountName>" -backend-config="container_name=tfstate" -backend-config="access_key=<YourStorageAccountAccessKey>" -backend-config="key=codelab.microsoft.tfstate"

export TF_VAR_client_id=<service-principal-appid>
export TF_VAR_client_secret=<service-principal-password>

terraform plan -out out.plan

terraform apply out.plan
```

# Test the Kubernetes cluster

```
echo "$(terraform output kube_config)" > ./azurek8s
export KUBECONFIG=./azurek8s
kubectl get nodes
```

# References

- https://docs.microsoft.com/en-us/azure/terraform/terraform-create-k8s-cluster-with-tf-and-aks
- https://www.terraform.io/docs/backends/types/azurerm.html
- https://www.hashicorp.com/blog/kubernetes-cluster-with-aks-and-terraform/
- https://www.terraform.io/docs/providers/azurerm/r/kubernetes_cluster.html
- https://www.terraform.io/docs/providers/azurerm/r/devspace_controller.html
