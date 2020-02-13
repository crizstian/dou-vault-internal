variable "access_key" {}
variable "secret_key" {}

variable "region1" {
  default = "us-west-2"
}

variable "tags" {
  default = {
    Project = "vault-internal-dou"
  }
}