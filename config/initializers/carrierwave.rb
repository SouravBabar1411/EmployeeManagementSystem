# CarrierWave.configure do |config|
#   config.storage    = :aws
#   config.aws_bucket = Rails.application.credentials[Rails.env.to_sym][:aws][:S3_BUCKET_NAME]
#   config.aws_acl    = 'public-read'
#   config.aws_authenticated_url_expiration = 60 * 60 * 24 * 7
#   config.aws_credentials = {
#     access_key_id:     Rails.application.credentials[Rails.env.to_sym][:aws][:AWS_ACCESS_KEY_ID],
#     secret_access_key: Rails.application.credentials[Rails.env.to_sym][:aws][:AWS_SECRET_ACCESS_KEY],
#     region:            Rails.application.credentials[Rails.env.to_sym][:aws][:AWS_REGION]
#   }
# end