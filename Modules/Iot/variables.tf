variable "environment" {
  description = "Deployment environment"

  type  = object ({
    name = string
  })
}

variable "thingname" {
  description = "name of thing"
  default = "dev-thing"
}