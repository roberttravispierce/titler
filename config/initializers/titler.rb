Titler.configure do |config|
  config.use_env_prefix = true
  config.delimiter = " - "
  config.app_name_position = "append" # append, prepend, none
  config.use_app_tagline = true
  config.admin_name = "Admin"
  config.admin_controller = AdminController
end
