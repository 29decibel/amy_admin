module AmyAdmin
  class Engine < Rails::Engine
    paths["app/controllers"] = "app/controllers/amy_admin"
    paths["app/views"] = "app/views"
  end
end
