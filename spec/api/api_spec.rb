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
    class ::ApplicationController
      def self.before_filter(f);end
      def self.layout(l);end
    end
    class MyApp < Rails::Application
      config.active_support.deprecation = :log
    end
    Rails.application = MyApp
    MyApp.initialize! rescue ''
  end

  let(:application) { ::AmyAdmin::Application.new }

  it "should have the dashboard controller" do
    ::AmyAdmin::DashboardController.should_not be_nil
  end
end
