locals {
  web_ips = [
    for instance in yandex_compute_instance.web : {
      address = instance.network_interface.0.nat_ip_address
      fqdn    = instance.fqdn
      index   = instance.count.index
    }
  ]

  db_ips = {
    main = {
      address = yandex_compute_instance.db["main"].network_interface.0.nat_ip_address
      fqdn    = yandex_compute_instance.db["main"].fqdn
      name    = "main"
    },
    replica = {
      address = yandex_compute_instance.db["replica"].network_interface.0.nat_ip_address
      fqdn    = yandex_compute_instance.db["replica"].fqdn
      name    = "replica"
    }
  }

  storage_ips = [
    {
      address = yandex_compute_instance.storage.network_interface.0.nat_ip_address
      fqdn    = yandex_compute_instance.storage.fqdn
    }
  ]
}

resource "local_file" "ansible_inventory" {
  content  = templatefile("${path.module}/inventory.tmpl", {
    web_ips     = local.web_ips,
    db_ips      = local.db_ips,
    storage_ips = local.storage_ips
  })
  filename = "${path.module}/ansible_inventory.ini"
}