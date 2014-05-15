require 'sidekiq'

Sidekiq.configure_client do |config|

  options = {:size => 1}

  unless ENV['REDISTOGO_URL'].blank?
    options[:url] = ENV['REDISTOGO_URL']
  end

  config.redis = options

end

Sidekiq.configure_server do |config|
  # The config.redis is calculated by the
  # concurrency value so you do not need to
  # specify this. For this demo I do
  # show it to understand the numbers

  options = {:size => 7}

  unless ENV['REDISTOGO_URL'].blank?
    options[:url] = ENV['REDISTOGO_URL']
  end

  config.redis = options

end
