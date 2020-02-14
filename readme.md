# Exemplo para provisionar infraestrutura como código com terraform

## Exemplo com ARM Template do Azure

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fsergioprates%2Fexemplo-terraform%2Fmaster%2Fazure-arm%2Fazuredeploy.json" target="_blank">
<img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png"/>
</a><a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Fsergioprates%2Fexemplo-terraform%2Fmaster%2Fazure-arm%2Fazuredeploy.json" target="_blank">
<img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/visualizebutton.png"/>
</a>

* Deploy de um banco MySQL
* Deploy de Um App Service com a connection string do banco criado
* Pelo azure é possível deixar templates cadastrados para fazer o deploy

### Passos para instalação terraform

https://www.terraform.io/downloads.html


### Comandos

    terraform init --Baixa o provider e plugins caso necessário

    terraform plan

    terraform apply

### Para funcionar com o azure

* Instalar o azure cli https://docs.microsoft.com/pt-br/cli/azure/install-azure-cli-apt?view=azure-cli-latest
* Logar no azure pelo azure cli seguindo as instruções do link abaixo:

    https://www.terraform.io/docs/providers/azurerm/guides/azure_cli.html

    

### Para funcionar com a aws

* Adicionar usuário administrador no IAM e baixar o CSV com as credenciais no fim do processo
* Instalar o aws CLI https://aws.amazon.com/pt/cli/
* Rodar o comando aws configure e colocar as credenciais que estão no CSV baixado no momento da criação do usuário

### Infraestrutura como código Google Cloud

    https://github.com/schweikert/gcp-infra-as-code/blob/master/cluster-1/cluster.yaml

### Coisas Interessantes

* https://www.azuredevopslabs.com/labs/vstsextend/terraform/
* https://docs.microsoft.com/en-us/azure/templates/microsoft.sql/2017-10-01-preview/servers/databases
* https://docs.microsoft.com/en-us/azure/mysql/concepts-pricing-tiers

    az mysql server create -l northeurope -g testgroup -n testsvr -u username -p password \ --sku-name B_Gen5_1 --ssl-enforcement Disabled \ --backup-retention 10 --geo-redundant-backup Enabled --storage-size 51200 --tags "key=value" --version {server-version}

    az group create --name ExemploLambda3 --location "Central US"
    az deployment create --resource-group ExemploLambda3 --location "Central US" --template-file ./azure-arm/azuredeploy.json


