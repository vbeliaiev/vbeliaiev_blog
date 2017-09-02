CarrierWave.configure do |config|
  # Use heroku vars on production
  if Rails.env.production?
    config.storage = :file
  # For testing, upload files to local `tmp` folder.
  elsif Rails.env.test? || Rails.env.development?
    config.storage = :file
    # config.enable_processing = false
    # config.root = "#{Rails.root}/tmp"
  else
    config.storage = :fog
  end

  config.cache_dir = "#{Rails.root}/tmp/uploads" # To let CarrierWave work on heroku

  # Fog::Storage.new(config.fog_credentials).sync_clock
end
