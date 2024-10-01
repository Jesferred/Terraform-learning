terraform {
  required_providers {
    virtualbox = {
      source  = "shekeriev/virtualbox"
      version = "0.0.4"
    }
  }
}



resource "virtualbox_vm" "node" {
  count = 1
  name  = format("node-%02d", count.index + 1)
  // image     = "https://app.vagrantup.com/ubuntu/boxes/bionic64/versions/20180903.0.0/providers/virtualbox.box"
  image  = "https://app.vagrantup.com/ubuntu/boxes/xenial64/versions/20211001.0.0/providers/virtualbox.box"
  cpus   = 2
  memory = "512 mib"

  /*network_adapter {
    type           = "hostonly"
    host_interface = "vboxnet1"
  }*/
  network_adapter {
    type = "hostonly"
    //device         = "IntelPro1000MTDesktop"

    //host_interface = "vboxnet1"

    //type           = "hostonly"
    //device         = "IntelPro1000MTDesktop"
    //host_interface = "vboxnet1"
    # On Windows use this instead
    host_interface = "VirtualBox Host-Only Ethernet Adapter"
  }



}

output "IPAddr" {
  value = element(virtualbox_vm.node.*.network_adapter.0.ipv4_address, 1)
}
