provider "aws" {
#use export command to use your env variables in order to authenticate
region  = "us-east-1"
}
resource "aws_s3_bucket" "zypers-s3" {
  bucket = "zypers-shared-docs-xxxxx"
  acl    = "private"
  versioning {
    enabled = true
  }
}

resource "aws_iam_group" "s3-group" {
    name = "s3-group"
    path = "/"
}

resource "aws_iam_group_policy" "s3-read" {
    name = "s3-read"
    group = "${aws_iam_group.s3-group.id}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
       "Action": [
                "s3:GetObject",
                "s3:ListBucket"
            ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.zypers-s3.bucket}"
    }
  ]
}
EOF
}