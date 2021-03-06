# See http://manuel.manuelles.nl/sidekiq-heroku-redis-calc/

unless configatron.redis.url.nil?

  require 'sidekiq'
  require 'uri'

  Sidekiq.configure_server do |config|
    config.poll_interval = 15
    config.redis = { :url => configatron.redis.url, :namespace => 'sidekiq', :size => 9 }
    config.server_middleware do |chain|
      chain.remove Sidekiq::Middleware::Server::ActiveRecord
      chain.add Kiqstand::Middleware
    end
  end

  # This goes in unicorn.rb
  # https://github.com/mperham/sidekiq/issues/120
  #
  # Sidekiq.configure_client do |config|
  #   config.redis = { :url => configatron.redis.url, :namespace => 'sidekiq', :size => 3 }
  # end

  redis_uri = URI.parse(configatron.redis.url)
  # Create a global variable to access the Redis DB
  $redis = if Rails.env.test?
    Redis.new
  else
    Redis.new(:host => redis_uri.host, :port => redis_uri.port, :password => redis_uri.password)
  end

end
