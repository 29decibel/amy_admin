class ::AmyAdmin::DashboardController < ::ApplicationController
  before_filter :authenticate_admin_user!
  layout 'amy_admin/admin'

  def home
  end

end
