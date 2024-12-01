{
    "name": "tf-setup-s3-read-write",
    "policy_statement": {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Deny",
                "Principal": "*",
                "Action": [
                    "s3:DeleteBucket",
                    "s3:DeleteObject"
                ],
                "Resource": [
                    "arn:aws:s3:::${bucket_name}",
                    "arn:aws:s3:::${bucket_name}/*"
                ]
            }
        ]
    }
}