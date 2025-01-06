provider "proxmox" {
  endpoint  = var.proxmox_api_endpoint
  api_token = var.proxmox_api_token
  insecure  = true
  ssh {
    agent    = true
    username = var.proxmox_user
  }
}


data "local_file" "ssh_public_key" {
  filename = "./id_rsa.pub"
}

resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
  count     = length(var.k8s_nodes)
  name      = "${var.k8s_nodes[count.index].name}"
  node_name = "proxmox"

  initialization {

    ip_config {
      ipv4 {
        address = "${var.k8s_nodes[count.index].ip}/${var.netmask}"
        gateway = "${var.gateway}"
      }
    }

    user_account {
      username = "ubuntu"
      keys     = [trimspace(data.local_file.ssh_public_key.content)]
    }
   
    dns {
      domain  = var.dnsdomain
      servers = var.nameserver
    }
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = var.ubuntu_img
    interface    = "scsi0"
    size         = 20
  }

  cpu {
    cores        = (var.k8s_nodes[count.index].master == true ? var.master_cpu : var.worker_cpu)
    type         = "x86-64-v2-AES"  # recommended for modern CPUs
  }

  memory {
    dedicated = (var.k8s_nodes[count.index].master == true ? var.master_memory : var.worker_memory)
  }

  network_device {
    bridge = var.proxmox_host_net
  }

}

