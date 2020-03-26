variable "dou_users" {
  default = [{
    entity_name = "marin"
    github_user = "marinsalinas"
    metadata = {
      organization = "DigitalOnUs"
      team         = "devops"
      is_admin     = false
    }
    }, {
    entity_name = "cristian"
    github_user = "crizstian"
    metadata = {
      organization = "DigitalOnUs"
      team         = "devops"
      is_admin     = true
    }
    }, {
    entity_name = "bernardo"
    github_user = "bernardogza"
    metadata = {
      organization = "DigitalOnUs"
      team         = "devops"
      is_admin     = true
    }
  }, {
    entity_name = "isaias"
    github_user = "isai"
    metadata = {
      organization = "DigitalOnUs"
      team         = "development"
      is_admin     = false
    }
  }]
}

variable "aws_roles" {
  default=[{
      name = "devops"
      role = "./files/aws/devops.json"
  }]
}

locals {
  temp  = [for key, member in var.dou_users : member.metadata.team]
  teams = concat(distinct(local.temp), ["admin"])
}

output "teams" {
  value = {
    admin  = module.entities.admins_name,
    devops = module.entities.devops_name,
    development = module.entities.development_name
  }
}