resource "aws_instance" "india_dev_jenkins" {
  instance_type               = var.jenkins_instance_type
  ami                         = var.ami_jenkins
  vpc_security_group_ids      = ["${var.jenkins_sg}"]
  key_name                    = aws_key_pair.jenkins_key.key_name
  subnet_id                   = "${var.india_dev_public_subnets[0]}"
  user_data                   = file("${path.module}/script.sh")
  associate_public_ip_address = true
  tags = merge(
    var.additional_tags,
    {
      Name = "${var.name}-jenkins-Server"
    }
  )
}

