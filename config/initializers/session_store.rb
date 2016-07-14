# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store, key: "_rails_base_session", domain: {
  production: ENV["COOKIES_DOMAIN"],
  development: ".dev.com"
}.fetch(Rails.env.to_sym, :all)
