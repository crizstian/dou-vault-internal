variable "dou_users" {
  default = [{
    entity_name = "marin"
    github_user = "marinsalinas"
    userpass    = "marin"
    metadata = {
      organization = "DigitalOnUs"
      team         = "DevOps"
    }
    }, {
    entity_name = "cristian"
    github_user = "crizstian"
    userpass    = "cristian"
    is_admin    = true
    metadata = {
      organization = "DigitalOnUs"
      team         = "DevOps"
    }
    }, {
    entity_name = "bernardo"
    github_user = "bernardogza"
    userpass    = "bernardo"
    metadata = {
      organization = "DigitalOnUs"
      team         = "DevOps"
    }
  }]
}
