output "cloudfront_identity" {
 value = aws_cloudfront_origin_access_identity.s3_cloudfront.iam_arn
}

output "domain_name" {
  value = aws_cloudfront_distribution.static_s3_distribution.domain_name
}
output "dns_zone" {
   value = aws_cloudfront_distribution.static_s3_distribution.hosted_zone_id
}