variable "each_vm" {
    type = map(object({
        vm_name     = string
        cores         = number
        memory         = number
        core_fraction  = number
        disk_volume = number
    }))
}

resource "yandex_compute_instance" "db" {
    for_each = var.each_vm

    name = each.value.vm_name
    platform_id = var.platform_id
    allow_stopping_for_update = true
    
    resources {
        cores         = each.value.cores
        memory        = each.value.memory
        core_fraction = each.value.core_fraction
    }

    boot_disk {
        initialize_params {
            image_id = data.yandex_compute_image.ubuntu.image_id
            size   = each.value.disk_volume
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
