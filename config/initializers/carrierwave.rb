CarrierWave.configure do |config|
  config.enable_processing = true
  # For testing, upload files to local `tmp` folder.
  if Rails.env.test?
    config.storage = :file
    config.root = "#{Rails.root}/tmp/"
  elsif Rails.env.development?
    config.storage = :file
    config.root = "#{Rails.root}/public/"
  else #staging, production
    config.fog_credentials = {
      :provider              => 'AWS',
      :aws_access_key_id     => ENV['S3_KEY'],
      :aws_secret_access_key => ENV['S3_SECRET']
    }
    config.cache_dir = "#{Rails.root}/tmp/uploads" # To let CarrierWave work on heroku
    config.fog_directory    = ENV['S3_BUCKET']
    config.fog_public     = false
    config.storage = :fog
  end
end