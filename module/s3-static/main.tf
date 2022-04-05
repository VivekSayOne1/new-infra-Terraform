resource "aws_s3_bucket" "sayone-terraform-s3" {
  bucket = var.bucket1
  
}



resource "aws_s3_bucket_website_configuration" "s3-website" {
  bucket = aws_s3_bucket.sayone-terraform-s3.bucket



  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  routing_rule {
    condition {
      key_prefix_equals = "docs/"
    }
    redirect {
      replace_key_prefix_with = "documents/"
    }
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.sayone-terraform-s3.id
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.sayone-terraform-s3.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
 statement {
     principals {
     type        = "AWS"
     identifiers = [var.cloudfront_origin_arn]
      #identifiers  = ["aws_iam_user.iam-user.id"]
    }  
    actions = [
       "s3:GetObject"
       
    ]

    resources = [
      
      "${aws_s3_bucket.sayone-terraform-s3.arn}/*",
     ]

          }
}