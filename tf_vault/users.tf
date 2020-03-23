variable "dou_users" {
  default = [{
    entity_name = "marin"
    github_user = "marinsalinas"
    userpass    = "marin"
    metadata = {
      organization = "DigitalOnUs"
      team         = "DevOps"
      is_admin    = false
    }
    }, {
    entity_name = "cristian"
    github_user = "crizstian"
    userpass    = "cristian"
    metadata = {
      organization = "DigitalOnUs"
      team         = "DevOps"
      is_admin    = true
    }
    }, {
    entity_name = "bernardo"
    github_user = "bernardogza"
    userpass    = "bernardo"
    metadata = {
      organization = "DigitalOnUs"
      team         = "DevOps"
      is_admin = true
    }
  }]
}

variable "aws_roles" {
default=[{
    name = "devops"
    role = "./files/aws/devops.json"
}]
}
