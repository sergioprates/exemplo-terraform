provider "azurerm" { }

resource "azurerm_resource_group" "slotDemo" {
  name = "exemploTerraForm"
  location = var.localizacao
}

resource "azurerm_app_service_plan" "slotDemo" {
  name                = "slotAppServicePlan"
  location            = azurerm_resource_group.slotDemo.location
  resource_group_name = azurerm_resource_group.slotDemo.name
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "slotDemo" {
  name                = var.nomeSite
  location            = azurerm_resource_group.slotDemo.location
  resource_group_name = azurerm_resource_group.slotDemo.name
  app_service_plan_id = azurerm_app_service_plan.slotDemo.id
  
  connection_string {
    name  = "Database"
    type  = "MySQL"
    value = "Server=${azurerm_mysql_server.demoMysql.fqdn};Port=3306;Database=${var.nomeBancoDeDados};Uid=${var.usuarioMySql}@${var.nomeRecursoBanco};Pwd=${var.senhaMySql};"
  }

  depends_on = [
    azurerm_mysql_server.demoMysql,
  ]
}

#resource "azurerm_app_service_slot" "slotDemo" {
# name                = "slotAppServiceSlotOne"
# location            = azurerm_resource_group.slotDemo.location
# resource_group_name = azurerm_resource_group.slotDemo.name
# app_service_plan_id = azurerm_app_service_plan.slotDemo.id
# app_service_name    = azurerm_app_service.slotDemo.name
#}

# INFRA MYSQL


resource "azurerm_mysql_server" "demoMysql" {
  name                = var.nomeRecursoBanco
  location            = azurerm_resource_group.slotDemo.location
  resource_group_name = azurerm_resource_group.slotDemo.name
# https://docs.microsoft.com/en-us/azure/mysql/concepts-pricing-tiers#compute-generations-vcores-and-memory
  sku_name = "B_Gen5_2"

  storage_profile {
    storage_mb            = 5120
    backup_retention_days = 7
    geo_redundant_backup  = "Disabled"
 }

  administrator_login          = var.usuarioMySql
  administrator_login_password = var.senhaMySql
  version                      = "8.0"
  ssl_enforcement              = "Enabled"
}


 provider "mysql" {
  version = "~> 1.6"
  endpoint = azurerm_mysql_server.demoMysql.fqdn
  username = "${var.usuarioMySql}@${var.nomeRecursoBanco}"
  password = var.senhaMySql
  tls = true
}

resource "azurerm_mysql_firewall_rule" "regraDeAcesso" {
  name                = "todoMundo"
  resource_group_name = azurerm_resource_group.slotDemo.name
  server_name         = azurerm_mysql_server.demoMysql.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
  depends_on = [
    azurerm_mysql_server.demoMysql
  ]
}

resource "mysql_database" "bancoDeDados" {
  name = var.nomeBancoDeDados
  default_character_set = "utf8"
  default_collation = "utf8_general_ci"

  depends_on = [
    azurerm_mysql_server.demoMysql
  ]

  #lifecycle {
    # prevent_destroy = true
  #}
}