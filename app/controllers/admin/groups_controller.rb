class Admin::GroupsController < ApplicationController
   layout 'admin'
   before_action :authenticate_admin!
   
    def index
      @groups = Group.all
    end
   
    def destroy
        @group = Group.find(params[:id])
        @group.destroy
        redirect_to admin_dashboards_path, notice: 'ユーザーを削除しました。'
    end
end
