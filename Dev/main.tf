module "dev" {
  source = "../Modules/Iot"
  environment = {
    name = "Dev"
  }
  thingname = "infra-watermark-apsouth-1-thing-demo"
}
