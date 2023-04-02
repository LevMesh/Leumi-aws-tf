resource "aws_iam_role" "ec2_s3_role" {
  name = "ec2-s3-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# resource "aws_iam_role_policy_attachment" "ec2_s3_policy_attachment" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
#   role       = aws_iam_role.ec2_s3_role.name
# }

resource "aws_iam_instance_profile" "ec2_s3_profile" {
  name = "ec2-s3-profile"
  role = aws_iam_role.ec2_s3_role.name
}

data "aws_iam_policy_document" "ec2_s3_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:DeleteObject"
    ]
    resources = [
      "${aws_s3_bucket.lev-leumi.arn}",
      "${aws_s3_bucket.lev-leumi.arn}/*"
    ]
  }
}

resource "aws_iam_policy" "ec2_s3_policy" {
  name   = "ec2-s3-policy"
  policy = data.aws_iam_policy_document.ec2_s3_policy.json
}

resource "aws_iam_role_policy_attachment" "ec2_s3_policy_attachment" {
  policy_arn = aws_iam_policy.ec2_s3_policy.arn
  role       = aws_iam_role.ec2_s3_role.name
}