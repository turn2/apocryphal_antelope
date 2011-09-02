# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_apocryphal_antelope_session',
  :secret      => '937ee2c37afee0462896cf5838b8904f11d6c209e3c1ac75ef66eabd59b2d764f5a31b7a72f283953ac9585dd4cbe72e80e898e8f67027252cbdf7c83dc209e0'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
