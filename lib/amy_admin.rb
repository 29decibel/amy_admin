require "amy_admin/version"
require "amy_admin/application"

module AmyAdmin
  class << self
    attr_accessor :application
    def application
      @application ||= ::Amy::Application.new
    end

    delegate :register, :to => :application
  end

end

# laod all register infos
configs = Dir[File.join(Rails.root,'app/admin_it/*.rb')]
configs.each {|file| load file }
