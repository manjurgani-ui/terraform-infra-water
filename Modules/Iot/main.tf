resource "aws_iot_thing" "example" {
  name = var.thingname
}

resource "tls_private_key" "key" {
	algorithm   = "RSA"
	rsa_bits = 2048
}

resource "tls_self_signed_cert" "cert" {
	private_key_pem = tls_private_key.key.private_key_pem

	validity_period_hours = 240

	allowed_uses = [
	]

	subject {
		organization = "test"
	}
}

resource "aws_iot_certificate" "cert" {
	certificate_pem = trimspace(tls_self_signed_cert.cert.cert_pem)
	active          = true
}

resource "aws_iot_thing_principal_attachment" "attachment" {
	principal = aws_iot_certificate.cert.arn
	thing     = aws_iot_thing.example.name
}


resource "aws_iot_policy" "pubsub" {
  name = "PubSubToAnyTopic"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "iot:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iot_policy_attachment" "att" {
  policy = aws_iot_policy.pubsub.name
  target = aws_iot_certificate.cert.arn
}

data "aws_iot_endpoint" "iot_endpoint" {
	endpoint_type = "iot:Data-ATS"
}

data "http" "root_ca" {
	url = "https://www.amazontrust.com/repository/AmazonRootCA1.pem"
}

