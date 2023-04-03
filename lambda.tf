resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "s3_get_only_policy" {
  name = "s3_list_and_get_policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::lev-leumi-bucket",
          "arn:aws:s3:::lev-leumi-bucket/*"
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "s3_put_only_policy" {
  name = "s3_put_policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:PutObject",
          "s3:ListBucket"
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::lev-lev-leumi-internal-bucket",
          "arn:aws:s3:::lev-leumi-internal-bucket/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_get_policy_attachment" {
  policy_arn = aws_iam_policy.s3_get_only_policy.arn
  role       = aws_iam_role.lambda_execution_role.name
}

resource "aws_iam_role_policy_attachment" "s3_put_policy_attachment" {
  policy_arn = aws_iam_policy.s3_put_only_policy.arn
  role       = aws_iam_role.lambda_execution_role.name
}

data "archive_file" "zip_the_python_code" {

  type        = "zip"
  source_dir  = "${path.module}/py-lambda/"
  output_path = "${path.module}/py-lambda/python-script.zip"
}


resource "aws_lambda_function" "lambda_function" {
  filename      = "${path.module}/py-lambda/python-script.zip"
  function_name = "s3_get_and_put"
  role          = aws_iam_role.lambda_execution_role.arn
  handler       = "python-script.lambda_handler"
  runtime       = "python3.8"

  depends_on = [
    aws_iam_role_policy_attachment.s3_put_policy_attachment,
    aws_iam_role_policy_attachment.s3_get_policy_attachment
  ]
}

resource "aws_s3_bucket_notification" "my_bucket_notification" {
  bucket = aws_s3_bucket.lev-leumi.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.lambda_function.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "*/*"
    # filter_suffix = ".txt"
  }
}






















#   source_code_hash = filebase64sha256("python-script.zip")

#   environment {
#     variables = {
#       BUCKET_NAME = aws_s3_bucket.lev-leumi.bucket
#     }
#   }

