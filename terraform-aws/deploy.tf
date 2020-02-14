provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}

resource "aws_db_instance" "demoMysql" {
  identifier = var.nomeRecursoBanco
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"
  name                 = "initial_db"
  username             = var.usuarioMySql
  password             = var.senhaMySql
  parameter_group_name = "default.mysql8.0"
  publicly_accessible  = true
  skip_final_snapshot  = true
  vpc_security_group_ids = [
      aws_security_group.permitirAcesso.id
  ]

  depends_on = [
      aws_security_group.permitirAcesso
  ]
}

 provider "mysql" {
  version = "~> 1.6"
  endpoint = aws_db_instance.demoMysql.address
  username = var.usuarioMySql
  password = var.senhaMySql
}


resource "mysql_database" "bancoDeDados" {
  name = var.nomeBancoDeDados
  default_character_set = "utf8"
  default_collation = "utf8_general_ci"

  #lifecycle {
    # prevent_destroy = true
  #}
}

resource "aws_security_group" "permitirAcesso" {
  name        = "group_seguranca_acesso_banco"
  description = "Permitir acesso ao banco"

  ingress {
    from_port   = 3306 
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_elastic_beanstalk_application" "app" {
  name = "app-net"
  description = "app-net-descricao"
}

resource "aws_elastic_beanstalk_environment" "app-env" {
  name = "app-env-nome"
  application = aws_elastic_beanstalk_application.app.name
  solution_stack_name = "64bit Windows Server Core 2019 v2.5.0 running IIS 10.0"

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name = "defaultConnection"
    value = "Server=${aws_db_instance.demoMysql.address};Port=3306;Database=${var.nomeBancoDeDados};Uid=${var.usuarioMySql}@${var.nomeRecursoBanco};Pwd=${var.senhaMySql};"
  }
}
