variable "amis" {
  type = map(string)
  default = {
    "us-east-1" = "ami-026c8acd92718196b"
    "us-east-2" = "ami-08962a4068733a2b6"
  }
}

variable "cdirs" {
  type = list(string)
  default = [
    "179.100.101.218/32"
  ]
}

variable "key_name_primary" {
  default = "key-access" 
}

variable "key_name_secondary" {
  default = "key-access-secondary" 
}
