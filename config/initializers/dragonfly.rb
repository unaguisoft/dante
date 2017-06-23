require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick, identify_command: "identify -limit memory 0 -limit map 0"

  secret "9ed28b586aef74be96d721b6f14c9526fb4571385ac2216dc77666a7b5761b48"

  url_format "/media/:job/:name"

  if (Rails.env.development? || Rails.env.test?)
    datastore :file,
              root_path: Rails.root.join('public/system/dragonfly', Rails.env),
              server_root: Rails.root.join('public')
  else
    datastore :s3,
              bucket_name: ENV['BUCKET_NAME'],
              access_key_id: ENV['S3_KEY'],
              secret_access_key: ENV['S3_SECRET'],
              url_scheme: 'https'
  end
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
