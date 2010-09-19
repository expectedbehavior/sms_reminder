# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_pepsi_refresh_reminder_session',
  :secret      => '6ed496dfab2cf7b4908cc01a97269de3f208ed5b6be4e3cd476ff0f675554819778438d77fabaedc821af71105a65d8d3d8c62fa5256db8a70ff5b77e2164eb4'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
