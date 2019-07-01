variable "server_count" {
  description = "Number of servers"
  default     = 0
}

variable "internal_macs" {
  description = "Internal server macs"
  type        = list(string)
}

variable "external_macs" {
  description = "external server macs"
  type        = list(string)
  default     = []
}

variable "enable_external_interfaces" {
  description = " enable external server macs"
  default     = true
}

variable "internal_mtu_bytes" {
  description = "Internal Maximum Transfer Unit bytes"
  default     = "9000"
}

#variable "controller_internal_mac" {}
