variable "k8s_nodes" {

  description="Create k8s nodes"
  type=list(object({
    name = string
    ip = string
    master = bool
  }))
  default = []
}

variable "ubuntu_img" {
  description="Disk image to use"
  type=string
}

variable "netmask" {
  description = "subnetmask"
  type = number
}

variable "dnsdomain" {
  description = "DNS domain"
  type = string
}

variable "gateway" {
  description = "gateway address"
  type = string
}

variable "nameserver" {
  description = "nameserver address"
  type = list(string)
}

variable "master_cpu" {
  description = "master cpu count"
  type = number
}

variable "master_memory" {
  description = "master memory"
  type = number
}

variable "worker_cpu" {
  description = "worker cpu count"
  type = number
}

variable "worker_memory" {
  description = "worker memory"
  type = number
}

variable "proxmox_api_endpoint" {
  type = string
  description = "Proxmox cluster API endpoint https://10.0.0.5:8006"
}

variable "proxmox_api_token" {
  type = string
  description = "Proxmox API token bpg proxmox provider with ID and token"
}

variable "proxmox_user" {
  type = string
  description = "Proxmox SSH User"
}

variable "proxmox_host_net" {
  type = string
  description = "Hostnet network interface"
}
