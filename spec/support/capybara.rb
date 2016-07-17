DEFAULT_HOST = "lvh.me".freeze
DEFAULT_PORT = 9887

Capybara.configure do |config|
  config.match = :prefer_exact
  config.javascript_driver = :webkit
  config.asset_host = "http://#{ENV.fetch('HOST')}"
  config.default_host = "http://#{DEFAULT_HOST}"
  config.server_port = DEFAULT_PORT
  config.app_host = "http://#{DEFAULT_HOST}:#{Capybara.server_port}"
end

def switch_to_subdomain(subdomain)
  Capybara.app_host = "http://#{subdomain}.#{DEFAULT_HOST}:#{DEFAULT_PORT}"
end
