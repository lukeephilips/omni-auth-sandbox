Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
    scope: 'public_profile', info_fields: 'id,name,link'
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_SECRET"], :skip_jwt => true,
    scope: 'profile', image_aspect_ratio: 'square', image_size: 48, access_type: 'online', name:
    'google'
  # provider :linkedin, ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET'],
  #   scope: 'r_basicprofile',
  #   fields: ['id', 'first-name', 'last-name', 'location', 'picture-url', 'public-profile-url']
  provider :strava, ENV['STRAVA_CLIENT_ID'], ENV['STRAVA_SECRET'],
   scope: 'public'
end

# OmniAuth.config.on_failure do |env|
#   error_type = env['omniauth.error.type'],
#   new_path = "#{env['SCRIPT_NAME']}#{OmniAuth.config.path_prefix}/failure?message=#{error_type}"
#   [301, {'Location' => new_path, 'Content-Type' => 'text/html'}, []]
# end
OmniAuth.config.on_failure = Proc.new do |env|
  SessionsController.action(:auth_failure).call(env)
end
