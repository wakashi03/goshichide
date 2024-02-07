Rails.application.config.sorcery.submodules = [:external]

Rails.application.config.sorcery.configure do |config|
  config.external_providers = [:line]

  config.line.key = ENV["LINE_KEY"]
  config.line.secret = ENV["LINE_SECRET"]
  config.line.callback_url = Settings.sorcery[:line_callback_url]
  config.line.scope = "profile"
  config.line.bot_prompt = 'aggressive'
  config.line.user_info_mapping = {
    name: 'displayName',
    email: 'userId'
  }

  config.user_config do |user|
    user.authentications_class = Authentication
    user.stretches = 1 if Rails.env.test?
  end

  config.user_class = "User"
end
