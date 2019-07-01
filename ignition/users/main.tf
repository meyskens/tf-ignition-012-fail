data "ignition_user" "rafa" {
  name                = "rafa"
  ssh_authorized_keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDOKGz9fvMCcvtsxWDyf7q40R2grY8gfe1He07VLHW3l+8m3tcGt27bu7JdX3OlimeYCAlUv//UcGFqC2hwReWNN+VVvV3sAQoFhUJkj0tXoRWcAEdvNRNC2OBjiVpRtz7iyb1GB2VAZ7WEqWSWXHgnTazFZ4gCJ0h6Xv6/IljAs/AYSWeRiLqXZYLcsSy4U/i+UbL0NGB1gntwafiUYwh717P43IRvfgdEaukP0YsqQ0VBWEe5X3yLDjDPmKoZNxhn+mj1Ps9wqcdcwh0sbS99Zf+Mc97ah/zC6pAnQs1fR+GFCcyfCcusWpSWPvQ+1SEaJm/UMq+ZA6An+kwbAjlb rafa@sourced.tech"]
  groups              = ["sudo", "docker"]
}

output "rafa" {
  value = data.ignition_user.rafa.id
}

data "ignition_user" "mcuadros" {
  name                = "mcuadros"
  ssh_authorized_keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDVI1AcnddL8rMnXBCwOtfGnCWSliLmamNn2NCYXQ6KaxmqQFPxW9iqVnSTrR7tL4jUZfUekc3WOmntCIDLng9jS8QmMKEU7k6YvxpgwU/1OTM/fST7VIK9gmhUm79qPKACZ/8wDk07lvbEiGZtE0ug1Kdn4wcwv89PUsVvCXgndJltseudbo6ge2NuKnyHDX1f87Wdcj0OG+p9YyVAS317EXvMhMYRkD1WYMIg8TGP2lOiYtE8W/W8Lh1rDLKJIDP7LK2wmvXsPhloAyG1ltIX3YTawJ/OagedF5K1q0bku5x1xFqC1CRMwSZ46RY3VhstUIcf8qw6KQh8cHiYN9pn mcuadros@mcuadros-xps-arch"]
  groups              = ["sudo", "docker"]
}

output "mcuadros" {
  value = data.ignition_user.mcuadros.id
}

data "ignition_user" "maartje" {
  name                = "maartje"
  ssh_authorized_keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC2ZFlWYw/VYDTptbXtIEhv5SwjwXktX55TyCTsJyOeQCjK3nTOZBQRHbcaUl5FmDT1qctCiUxFNT5NB2UvNbGqaSzCB9JEqOs/tzcZhZU4ZBShJ5dEFFVtmz+1lWcx5/A5R50HRkiDnAjQGxRkGSrOxvGJeu7tBhDokNvH+RWj2iVdG7wBSKO0aXKfio6kJZqvlkDnfVE4ZuypowydfdfOAAx5mQzNZ0fRHmVRwZqRd55dLzbo0z4af/CjIfWQSOb5fRsNgrAQ3CroenpnbLmMjQj0fmiBQwL/1K/As/AVe7pjbUrG9u9IIrLPv2/OAXOirMbOwb2z0LZ7sj4iYrmB maartje@maartje-XPS-13-9370"]
  groups              = ["sudo", "docker"]
}

output "maartje" {
  value = data.ignition_user.maartje.id
}

data "ignition_user" "driosalido" {
  name                = "driosalido"
  ssh_authorized_keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDNDo3MVsVXao/PR8Ww6bmNyZuu+96wnXNMk4hvFW70GkhAnzqu8QIhktXo+AWjZDAPAlGt0oEV8yQk2nsFNBqKVcxCAmz8yyy/1GvCymRGV3soRuOjv+R3taZanRYvde0yh63F3JWkq0T1qvbDclKtylj47/jWPSfi21wqxspET1JRlF+NqUBqCbBGp5SoQOrpyKgWnvNVBVESKGkdrdMFz/RkV7C/UFKHin/4CGETzlgkU7dUkyiEB73wVO7dZeZYStJWZqliVBNxRZHuHjDPZH0NDR6b0IPqGy0apLKuy2pc6iuRkHnwdwBpOgod6h7SQL/hfn7mqcxvavhx3fxyYx8YMvCIrzKuBZbme1QfJKNNqOVWMwWF0MPawLQGD+GirIpZQ5hOq3HEGxW2AWQK62AC4BRj2UVAc0WqyBDt0eVWrzD/l1sO+w2fkgV3jfI2SYIGsCSZE/tYWH50Caxf066SQrIqMwxOUGwxS5WWuw3Of2/a1uqhxmJgYjtAOeBtdDQEBYQdV+ExgObMmH5L3vDAoxGV9GRo7S0UsVjqsOI55LWfNR2ENUhawHOTyOBxshE66FS87Xf2WbPTIijZXgAShn0qNfCmcODgj2p1KagET2G0aJKKHAS2nv7UUpPCtmOZWjROUm7fhXSr6urwW1WpmUTFvYpoou82LxswGQ== driosalido"]
  groups              = ["sudo", "docker"]
}

output "driosalido" {
  value = data.ignition_user.driosalido.id
}

# password is the standard source{d} tyba passwd
# cannot be used for ssh, but could be helpful to access via console
data "ignition_user" "sourced" {
  name                = "sourced"
  password_hash       = "$6$KarlVo9enuWzD$jP/BNVNB7PX0iSYt.ItSW6SoJyB6PXWwpqUIo.WzlWk3d.KNJWfFTrixk/RaiXPjkY.7Bn4dIlzZV0d0Fdv54/"
  ssh_authorized_keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDVjacTe3LpBRfQSnFE+yODxDMADCcf4w2I7HbWhkKGLhFb8CcjjZqP/vKtz/BMJu8fOpamUINVWaNDMbigQp6eq5VHssHltzuxOc0BhjQ6tmknTEoWXgH/j427i0ddrEnNH2wdkEgtZ94q1TI/K5Zk1Uvo1kbHmIINq3ERT4uoHqZQFAhDmY0itS2Yyu6qJRS8sSlA78ed8hA7GswR1tLrKU+BS8MlLEZPgu8AFW52R+EE3qTNwXJFBiptSW4aqM7zzCujc2zxQRPgz4LH3QpD3pQ+8TNkDhydpQHcdC47SbbhzHA7O+QYRihqHLVCCKTiJc2jpZHwJzBA+5VWHXkj infra@sourced.tech"]
  groups              = ["sudo", "docker"]
}

output "sourced" {
  value = data.ignition_user.sourced.id
}

output "all" {
  value = [
    data.ignition_user.rafa.id,
    data.ignition_user.mcuadros.id,
    data.ignition_user.maartje.id,
    data.ignition_user.driosalido.id,
    data.ignition_user.sourced.id,
  ]
}

