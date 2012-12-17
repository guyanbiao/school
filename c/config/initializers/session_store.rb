# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_c_session',
  :secret      => 'cfdff67f1cebd56acbd9d1ae963d6dc4c63234b036f69e1a531a1a7ddc4d6708edd28457270e7cd8dc132bf100ab19e2ec75f4a9c5bd5b3033e68b06864821a0'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
