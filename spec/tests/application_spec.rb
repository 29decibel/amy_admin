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

  it "should register infos" do
    application.register 'topics'
    application.meta_infos.count.should == 1
  end

  it "should define the index infos" do
    application.register 'topics',{
      :index => [:id,:name],
      :menu => 'nice topics'
    }
    application.meta_infos['topics'].should_not be_nil
    application.meta_infos['topics'][:index].count.should == 2
  end

  it "should generate controllers by model_name" do
  end

  it "should generate routes by model_name" do

  end

end
