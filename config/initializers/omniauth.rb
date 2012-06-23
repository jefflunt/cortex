Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :google_oauth2,   ENV['CORTEX_GOOGLE_ID'],  ENV['CORTEX_GOOGLE_SECRET'], { :scope => 'userinfo.email' }
  # provider :facebook, ENV['CORTEX_FB_APP_ID'], ENV['CORTEX_FB_APP_SECRET'], {:scope => 'user_about_me'}
  # provider :twitter,  ENV['CORTEX_TW_KEY'],    ENV['CORTEX_TW_SECRET']
  # provider :github,   ENV['CORTEX_GITHUB_ID'], ENV['CORTEX_GITHUB_SECRET']
end