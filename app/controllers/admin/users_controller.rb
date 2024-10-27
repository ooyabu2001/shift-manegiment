class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!


    def index
      @users=User.all
      render partial: 'admin/dashboards/user', collection: @users
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        redirect_to admin_dashboards_path, notice: 'ユーザーを削除しました。'
    end
end
