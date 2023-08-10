resource "aws_eip" "eip-jenkins" {
  instance = aws_instance.india_dev_jenkins.id
  tags = merge(
    var.additional_tags,
    {
      Name = "${var.name}EIP-jenkins-Server"
    }
  )
}
resource "aws_eip_association" "eip-association" {
  instance_id   = aws_instance.india_dev_jenkins.id
  allocation_id = aws_eip.eip-jenkins.id
}
