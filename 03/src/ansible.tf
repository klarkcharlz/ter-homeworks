locals {
  web_ips = [
    for i, instance in yandex_compute_instance.web : {
      address = instance.network_interface.0.nat_ip_address
      fqdn    = instance.fqdn
      index   = i
    }
  ]
}

resource "local_file" "ansible_inventory" {
  content  = templatefile("${path.module}/inventory.tmpl", {
    web_ips = local.web_ips, 
    db_ips = {
      main    = {
        address = yandex_compute_instance.db["main"].network_interface.0.nat_ip_address
        fqdn    = yandex_compute_instance.db["main"].fqdn
        name    = "main"
      },
      replica = {
        address = yandex_compute_instance.db["replica"].network_interface.0.nat_ip_address
        fqdn    = yandex_compute_instance.db["replica"].fqdn
        name    = "replica"
      }
    },
    storage_ip = {
      address = yandex_compute_instance.storage.network_interface.0.nat_ip_address
      fqdn    = yandex_compute_instance.storage.fqdn
    }
  })
  filename = "${path.module}/ansible_inventory.ini"
}