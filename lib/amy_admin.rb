require "rails/all"

require "amy_admin/version"
require "amy_admin/engine"
require "amy_admin/application"


module AmyAdmin
  class << self
    def application
      @app ||= ::AmyAdmin::Application.new
    end

    def register(name,options={})
      self.application.register(name,options)
    end

  end


end
