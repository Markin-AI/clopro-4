resource "yandex_mdb_mysql_cluster" "markinai" {
  name        = "markinai"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.HW_Netology.id
  version     = "8.0"
  deletion_protection = true

  resources {
    resource_preset_id = "b1.medium"
    disk_type_id       = "network-hdd"
    disk_size          = 20
  }

  maintenance_window {
    type = "WEEKLY"
    day  = "SAT"
    hour = 16
  }

  backup_window_start {
    hours = 23
    minutes = 59
  }

  host {
    zone      = "ru-central1-a"
    name      = "a-1"
    subnet_id = yandex_vpc_subnet.public_a.id
  }

  host {
    zone      = "ru-central1-b"
    name      = "b-1"
    subnet_id = yandex_vpc_subnet.public_b.id
  }

  host {
    zone                    = "ru-central1-a"
    name                    = "a-2"
    replication_source_name = "b-1"
    subnet_id               = yandex_vpc_subnet.private_a.id
  }

  host {
    zone                    = "ru-central1-b"
    name                    = "b-2"
    replication_source_name = "a-1"
    subnet_id               = yandex_vpc_subnet.private_b.id
  }
}

resource "yandex_mdb_mysql_database" "netology_db" {
  cluster_id = yandex_mdb_mysql_cluster.markinai.id
  name       = "netology_db"
}

resource "yandex_mdb_mysql_user" "markin" {
  cluster_id = yandex_mdb_mysql_cluster.markinai.id
  name       = "markin"
  password   = "password"

  permission {
    database_name = yandex_mdb_mysql_database.netology_db.name
    roles         = ["ALL"]
  }

  connection_limits {
    max_questions_per_hour   = 10
    max_updates_per_hour     = 20
    max_connections_per_hour = 30
    max_user_connections     = 40
  }

  global_permissions = ["PROCESS"]

  authentication_plugin = "SHA256_PASSWORD"
}