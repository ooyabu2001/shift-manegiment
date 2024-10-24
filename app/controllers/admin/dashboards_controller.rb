class Admin::DashboardsController < ApplicationController
  before_action :authenticate_admin!

  def index
     @users = User.all
     @group =Group.all
  end
end
