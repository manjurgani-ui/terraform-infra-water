output "THING-NAME" {
	value = module.dev.thing_name
}

output "CERTIFICATE" {
	value = module.dev.cert
}

output "PRIVATE-KEY" {
	value = module.dev.key
	sensitive = true
}

output "IOT-END-POINT" {
	value = module.dev.iot_endpoint
}

output "ROOT_CA" {
	value = module.dev.ca
}