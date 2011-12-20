# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rails-2.3.x-test_app_session',
  :secret      => '2c71ec9162c2052dd3de58ff375a05d46a13224a28aa5f30a8f25757ec15bda2d101ab6a9e72cb9daa575e1638d94f7c9284afd18833b0dbfef81c5b48eb65a3'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
