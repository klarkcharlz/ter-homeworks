resource "yandex_compute_disk" "example" {
  count = 3

  name = "disk-${count.index + 1}"
  size = 1

  zone = var.default_zone
}


resource "yandex_compute_instance" "storage" {
    name        = "storage"
    platform_id = var.platform_id

    resources {
        cores         = 2
        memory        = 2
        core_fraction = 20
    }

    boot_disk {
        initialize_params {
            image_id = data.yandex_compute_image.ubuntu.image_id
            size     = 10
        }
    }

    network_interface {
        subnet_id = yandex_vpc_subnet.develop.id
        nat       = true
    }

    dynamic "secondary_disk" {
        for_each = toset([for disk in yandex_compute_disk.example: disk.id])

        content {
            disk_id = secondary_disk.value
        }
    }

    metadata = {
        "ssh-keys" = "ubuntu:${local.public_ssh_key}"
    }
}
