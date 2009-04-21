# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_heroku_angelbob_session',
  :secret      => '0cbf70aed357a63db7c0733f09c32e26c8430eec46407cd8e05f44bc3b2b07105cbdf1b5f1d7740f10ad819db130c6d061be3c13410b5d876417d11683e977b9'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
