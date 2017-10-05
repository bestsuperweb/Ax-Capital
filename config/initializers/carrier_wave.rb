CarrierWave.configure do |config|
  # heroku config:add
  # S3_KEY=your_s3_access_key
  # S3_SECRET=your_s3_secret
  # S3_REGION=euwest1
  # S3_BUCKET_NAME=s3_bucket/folder

  # For testing, upload files to local `tmp` folder.
  # if Rails.env.test? || Rails.env.cucumber?
  #   config.storage = :file
  #   config.enable_processing = false
  #   config.root = "#{Rails.root}/tmp"
  # else
  #   config.storage = :fog
  # end
  #
  # config.cache_dir = "#{Rails.root}/tmp/uploads"
  #
  # config.fog_directory  = ENV['S3_BUCKET_NAME']
  # config.fog_public     = true
  # config.fog_attributes = {'CacheControl'=>'maxage=315576000'}
end
