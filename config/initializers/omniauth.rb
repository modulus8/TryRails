require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, "64c53ef52397425abe86863d281d25fb", "8c91939166924e51a0ef100fa54a6d1f", scope: 'user-read-email playlist-modify-public user-library-read user-library-modify'
end
