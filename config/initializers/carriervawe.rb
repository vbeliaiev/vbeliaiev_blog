CarrierWave.configure do |config|
  # Use heroku vars on production

    config.storage = :file
  # For testing, upload files to local `tmp` folder.

  # Fog::Storage.new(config.fog_credentials).sync_clock
end
