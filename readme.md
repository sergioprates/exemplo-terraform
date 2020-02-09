# Exemplo para provisionar infraestrutura como código com terraform

## Exemplo com ARM Template do Azure

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fsergioprates%2Fexemplo-terraform%2Fmaster%2Fazure-arm%2Fazuredeploy.json" target="_blank">
<img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png"/>
</a><a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Fsergioprates%2Fexemplo-terraform%2Fmaster%2Fazure-arm%2Fazuredeploy.json" target="_blank">
<img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/visualizebutton.png"/>
</a>

* Deploy de um banco MySQL
* Deploy de Um App Service com a connection string do banco criado


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