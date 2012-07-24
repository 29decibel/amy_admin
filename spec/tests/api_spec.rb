require 'spec_helper'

describe AmyAdmin::Application do
  before(:all) do
    class Topic;end
    module ::InheritedResources
      class Base
        def self.before_filter(filter);end
        def self.defaults(model);end
        def self.has_scope(model,arg2);end
        def self.respond_to(model);end
      end
    end
    class MyApp < Rails::Application
      config.active_support.deprecation = :log
    end
    Rails.application = MyApp
    MyApp.initialize!
  end

  let(:application) { ::AmyAdmin::Application.new }

end
