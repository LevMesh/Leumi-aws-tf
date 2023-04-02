resource "aws_s3_bucket" "lev-leumi" {
  bucket = "lev-leumi-bucket"

  tags = {
    Name        = "lev-bucket"
  }
}
