CarrierWave.configure do |config|
  rails_secrets = Rails.application.secrets

  # Use secrets.yml on development
  if Rails.env.development?
    config.fog_credentials = {
        :provider              => 'AWS',
        :aws_access_key_id     => rails_secrets.S3_KEY,
        :aws_secret_access_key => rails_secrets.S3_SECRET,
        :region                => rails_secrets.S3_REGION,
        endpoint:              rails_secrets.S3_PATH
    }
    config.fog_directory = rails_secrets.S3_BUCKET_NAME
  end

  # Use heroku vars on production
  if Rails.env.production?
    config.fog_credentials = {
        provider:              'AWS',
        aws_access_key_id:     ENV['S3_KEY'],
        aws_secret_access_key: ENV['S3_SECRET'],
        region:                ENV['S3_REGION'],
        endpoint:              ENV['S3_PATH']
    }
    config.fog_directory = ENV['S3_BUCKET_NAME']
  end

  # For testing, upload files to local `tmp` folder.
  if Rails.env.test?
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"
  else
    config.storage = :fog
  end

  config.cache_dir = "#{Rails.root}/tmp/uploads"                  # To let CarrierWave work on heroku
  Fog::Storage.new(config.fog_credentials).sync_clock if Rails.env.development?
end
