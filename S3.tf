resource "aws_s3_bucket" "lev-leumi" {
  bucket = "lev-leumi-bucket"
}


resource "aws_s3_bucket" "lev-leumi-internal" {
  bucket = "lev-leumi-internal-bucket"
}