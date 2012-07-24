require 'spec_helper'

describe AmyAdmin do

  it "should call application's register method" do
    app = mock :application
    app.should_receive(:register)
    AmyAdmin.stub(:application).and_return(app)
    AmyAdmin.register 'topics'
  end
end
