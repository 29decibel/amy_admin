require "amy_admin/version"
require "amy_admin/application"


module AmyAdmin
  class << self
    def application
      @application ||= ::Amy::Application.new
    end

    def register(name,options={})
      application.register(name,options)
    end

  end

end

if defined?(Rails) and !Rails.root.blank?
  # laod all register infos
  configs = Dir[File.join(Rails.root,'app/amy_admin/*.rb')]
  configs.each {|file| load file }
end
