HoptoadNotifier.configure do |config|
  config.api_key = 'Angelbob\'s Blog'
  config.host = 'cheaptoad-catcher.heroku.com'
  config.port = 80

  config.environment_filters << "BLOG_PASSWORD"

  config.ignore_only = []
end
