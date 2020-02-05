provider "azurerm" {
  
  version = "=1.43.0"
  subscription_id = "00000000-0000-0000-0000-000000000000"
}

resource "azurerm_resource_group" "api_clientes_resource_group" {
    name = "api_clientes_resource_group"
    location = "West US"
}


resource "azurerm_app_service_plan" "service_plan_api_clientes" {
    name = "service_plan_api_clientes"
    location = "${azurerm_resource_group.api_clientes_resource_group.location}"
    resource_group_name = "${azurerm_resource_group.api_clientes_resource_group.name}"

    sku {
        tier = "Standard"
        size = "S1"
    }
  
}


resource "azurerm_app_service" "api_clientes_app_service" {
    name = "api_clientes_app_service"
    location = "${azurerm_resource_group.api_clientes_resource_group.location}"
    resource_group_name = "${azurerm_resource_group.api_clientes_resource_group.name}"
    app_service_plan_id = "${azurerm_app_service_plan.service_plan_api_clientes.id}"
  
    site_config {
        always_on = true
    }

    app_settings = {
        "chave" = "chave"
    }

    connection_string {
        name = "Database"
        type = "SQLServer"
        value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
    }
}

