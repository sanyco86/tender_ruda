Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379/0', namespace: "tender_ruda_#{Rails.env}" }
  if(database_url = ENV['DATABASE_URL'])
    pool_size = Sidekiq.options[:concurrency] + 2
    ENV['DATABASE_URL'] = "#{database_url}?pool=#{pool_size}"
    ActiveRecord::Base.establish_connection
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379/0', namespace: "tender_ruda_#{Rails.env}" }
end
