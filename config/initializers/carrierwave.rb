require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

def use_s3?
  if Rails.env.development? || Rails.env.test?
    false
  else
    true
  end
end

CarrierWave.configure do |config|
  config.cache_dir = "#{Rails.root}/tmp/uploads"

  if use_s3?
    config.fog_provider  = 'fog/aws'
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV.fetch('S3_ACCESS_KEY', ''),
      aws_secret_access_key: ENV.fetch('S3_SECRET_KEY', ''),
      region:                ENV.fetch('S3_REGION', '')
    }
    config.fog_directory  = ENV.fetch('S3_BUCKET', '')
    config.fog_public     = false
    config.fog_authenticated_url_expiration = 60
    config.storage = :fog
    config.cache_storage = :fog
  else
    config.storage = :file
  end
end
