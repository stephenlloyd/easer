# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_dieteaser_session',
  :secret      => '1571901b72704228777f2371ef737e809c2dc276ac20e924e18eede9a8150965dc5de4d46249226df73ee910f243cc1682612c4cdc36e9c1b64691b399d7dbb8'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
