terraform {
}

resource "yandex_compute_instance" "vm-1" {
  name = "viktor"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      # ubuntu 20-04
      image_id = "fd80d7fnvf399b1c207j"
      # debian11
#      image_id= "fd8fhgufmvsgqk4r1h24"
      size     = 30
    }
  }

  network_interface {
    subnet_id = "e9bdm4sf17ld6s3n9mqn"
    nat       = true
  }

  metadata = {
#    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
    user-data = "${file("./meta.yml")}"
  }

  scheduling_policy {
    preemptible = true
  }
}

  output "internal_ip_address_vm_1" {
    value = yandex_compute_instance.vm-1.network_interface.0.ip_address
  }
  output "external_ip_address_vm_1" {
    value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
  }
#resource "yandex_compute_instance" "vm-2" {
#  name = "viktor2"

#  resources {
#    cores         = 2
#    memory        = 2
#    core_fraction = 20
#  }

#  boot_disk {
#    initialize_params {
#      # ubuntu 20-04
#      image_id = "fd80d7fnvf399b1c207j"
#      # debian11
#     # image_id= "fd8fhgufmvsgqk4r1h24"
#      #size     = 60
#    }
#  }

#  network_interface {
#    subnet_id = "e9bdm4sf17ld6s3n9mqn"
#    nat       = true
#  }

#  metadata = {
#    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
#  }

#}



#data "template_file" "inventory" {
 # template = file("./terraform/_templates/inventory.tpl")
 # 
  #vars = {
   # user = "ubuntu"
    #host = join("", [yandex_compute_instance.viktor.name, " ansible_host=", #yandex_compute_instance.viktor.network_interface.0.nat_ip_address])
 # }
#}
#
#resource "local_file" "save_inventory" {
 # content  = data.template_file.inventory.rendered
#  filename = "./inventory"
#}
