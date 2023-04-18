# Configure the AWS provider
provider "aws" {
  region = "us-east-1"
}

# Create an S3 bucket
resource "aws_s3_bucket" "jenkins-bucket" {
  bucket = "vals-jenkins-bucket"
  acl    = "private"
}

# Create two EC2 instances
resource "aws_instance" "example_instance_1" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  count         = 2
  tags = {
    Name = "example-instance-${count.index + 1}"
  }
}

# Attach the S3 bucket to the instances
resource "aws_s3_bucket_object" "jenkins_object" {
  bucket = aws_s3_bucket.example_bucket.id
  key    = "example-object"
  source = "example.txt"
  depends_on = [
    aws_instance.example_instance_1
  ]
}
