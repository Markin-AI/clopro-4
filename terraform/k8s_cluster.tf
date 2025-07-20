resource "yandex_kubernetes_cluster" "regional_cluster_resource_name" {
  name        = "markinai"
  description = "description"
  network_id = yandex_vpc_network.HW_Netology.id
  master {
    master_location {
      zone      = yandex_vpc_subnet.public_a.zone
      subnet_id = yandex_vpc_subnet.public_a.id
   }
    master_location {
      zone      = yandex_vpc_subnet.public_b.zone
      subnet_id = yandex_vpc_subnet.public_b.id
    }
    master_location {
      zone      = yandex_vpc_subnet.public_d.zone
      subnet_id = yandex_vpc_subnet.public_d.id
    }
    
    public_ip = true

    maintenance_policy {
      auto_upgrade = true

    }

    master_logging {
      enabled                    = true
      kube_apiserver_enabled     = true
      cluster_autoscaler_enabled = true
      events_enabled             = true
      audit_enabled              = true
    }
  }

  service_account_id      = yandex_iam_service_account.sa.id
  node_service_account_id = yandex_iam_service_account.sa.id

  labels = {
    my_key       = "my_value"
    my_other_key = "my_other_value"
  }

  release_channel         = "RAPID"
  network_policy_provider = "CALICO"

  kms_provider {
    key_id = yandex_kms_symmetric_key.key-a.id
  }
}

// Create SA
resource "yandex_iam_service_account" "sa" {
  folder_id = var.folder_id
  name      = "tf-test-sa"
}

// Grant permissions
resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

// Create Static Access Keys
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}

resource "yandex_kms_symmetric_key" "key-a" {
  name              = "example-symetric-key"
  description       = "description for key"
  default_algorithm = "AES_128"
  rotation_period   = "8760h" // equal to 1 year
}

resource "yandex_kubernetes_node_group" "k8s-ng" {
  cluster_id = yandex_kubernetes_cluster.regional_cluster_resource_name.id
  name        = "k8s-ng"
  description = "node group"
  version     = "1.29"
  instance_template {
    name = "test-{instance.short_id}-{instance_group.id}"
    platform_id = "standard-v3"
    network_acceleration_type = "standard"
    network_interface {
      nat        = true
      subnet_ids = ["${yandex_vpc_subnet.private_d.id}"]
    }

    resources {
      memory = 2
      cores  = 2
      core_fraction = 20
    }

    boot_disk {
      type = "network-hdd"
      size = 50
    }

    scheduling_policy {
      preemptible = true
    }

    container_runtime {
      type = "containerd"
    }

    metadata = var.vm_metadata

  }

  scale_policy {
    auto_scale {
      min     = 3
      max     = 6
      initial = 3
    }
  }

  allocation_policy {
    location {
      zone = "ru-central1-d"
    }
  }

}