CarrierWave.configure do |config|
  rails_secrets = Rails.application.secrets

  unless Rails.env.test?
    config.fog_credentials = {
        :provider              => 'AWS',
        :aws_access_key_id     => rails_secrets.S3_KEY,
        :aws_secret_access_key => rails_secrets.S3_SECRET,
        :region                => rails_secrets.S3_REGION,
        endpoint:              rails_secrets.S3_PATH
        # host:                  's3.example.com',             # optional, defaults to nil

    }
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

  config.fog_directory    = rails_secrets.S3_BUCKET_NAME
  Fog::Storage.new(config.fog_credentials).sync_clock
end
