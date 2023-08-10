provider "aws" {
  region = "eu-north-1"  # Change this to your desired region
}

resource "aws_instance" "example" {
  ami           = "ami-0989fb15ce71ba39e"  # Replace with your desired AMI ID
  instance_type = "t3.micro"
}

# Output the instance metadata as JSON
resource "null_resource" "metadata_query" {
  triggers = {
    instance_id = aws_instance.example.id
  }

  provisioner "local-exec" {
    command = "aws ec2 describe-instances --instance-ids ${self.triggers.instance_id} --query 'Reservations[0].Instances[0]' --output json > instance_metadata.json"
  }
}
