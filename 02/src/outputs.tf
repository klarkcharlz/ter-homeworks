 output "vm_info" {
     value = {
       "web_instance_name" = yandex_compute_instance.platform.name
       "web_external_ip"   = yandex_compute_instance.platform.network_interface.0.nat_ip_address
       "web_fqdn"          = yandex_compute_instance.platform.fqdn

       "db_instance_name"  = yandex_compute_instance.db.name
       "db_external_ip"    = yandex_compute_instance.db.network_interface.0.nat_ip_address
       "db_fqdn"           = yandex_compute_instance.db.fqdn
     }
   }
