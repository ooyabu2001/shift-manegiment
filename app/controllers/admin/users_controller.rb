class Admin::UsersController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!


    def index
      @users = User.all
      render layout: 'admin', partial: 'admin/dashboards/user'
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        redirect_to admin_dashboards_path, notice: 'ユーザーを削除しました。'
    end
end
