data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image_family
}

variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
  }))
  description = "Map of resources for VMs"
}

resource "yandex_compute_instance" "web" {
    count = 2
    name = "web-${count.index + 1}"
    platform_id = var.platform_id
    allow_stopping_for_update = true

    resources {
        cores         = var.vms_resources["web"].cores
        memory        = var.vms_resources["web"].memory
        core_fraction = var.vms_resources["web"].core_fraction
    }

    boot_disk {
        initialize_params {
            image_id = data.yandex_compute_image.ubuntu.image_id
        }
    }

    scheduling_policy {
        preemptible = true
    }

    network_interface {
        subnet_id = yandex_vpc_subnet.develop.id
        nat       = true
        security_group_ids = ["enpbuu26oihjsno25r2h", "enp4hpomv8paabnuc4e2"]
    }

    metadata = {
        "ssh-keys" = "ubuntu:${local.public_ssh_key}"
    }
}
