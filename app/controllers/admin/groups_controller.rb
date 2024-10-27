class Admin::GroupsController < ApplicationController
   before_action :authenticate_admin!
    def destroy
        @group = Group.find(params[:id])
        @group.destroy
        redirect_to admin_dashboards_path, notice: 'ユーザーを削除しました。'
    end
end
