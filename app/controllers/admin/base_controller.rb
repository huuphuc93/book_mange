class Admin::BaseController < ApplicationController
  layout "admin/layouts/application"
  before_action :logged_in_user
  before_action :check_admin
  
  private
  
  def check_admin
    return if current_user.admin?
    flash[:error] = "You don't have permission to access"
    redirect_to root_path
  end
end