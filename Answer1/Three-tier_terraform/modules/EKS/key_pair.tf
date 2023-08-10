resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


resource "aws_key_pair" "node_key" {
  key_name   = "${var.name}-node-key" # Crindiate a "myKey" to AWS!!
  public_key = tls_private_key.pk.public_key_openssh

  provisioner "local-exec" { # Crindiate a "myKey.pem" to your computer!!
    command = "echo '${tls_private_key.pk.private_key_pem}' > ./node.pem"
  }
}
