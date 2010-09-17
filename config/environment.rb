# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.8' unless defined? RAILS_GEM_VERSION

passwords_file = File.join(File.dirname(__FILE__), "..", "..", "Passwords.sh")
if File.exist? passwords_file
  blog_password = `. #{passwords_file}; echo $BLOG_PASSWORD`.chomp
  ENV['BLOG_PASSWORD'] = blog_password
end

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Specify gems that this application depends on and have them installed with rake gems:install
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"
  config.gem "has_many_polymorphs"
  config.gem "hoptoad_notifier"
  #config.gem "mislav-will_paginate", :version => "~> 2.3.8",
  #             :lib => "will_paginate", :source => 'http://gems.github.com'

  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'UTC'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de
end
require 'tagging_extensions'
require 'will_paginate'

# This is used to keep PostGRES and other picky databases happy with the
# long-url-name hack
#class ActiveRecord::Base
#  def self.find_from_ids_with_coercion(id, options)
#    find_from_ids_without_coercion(id.to_i, options)
#  end
#  alias_method :find_from_ids_without_coercion, :find_from_ids
#  alias_method :find_from_ids, :find_from_ids_with_coercion
#end
