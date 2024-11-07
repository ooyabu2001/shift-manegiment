class Admin::GroupsController < ApplicationController
   layout 'admin'
   before_action :authenticate_admin!

    def index
      @groups = Group.all
    end

    def destroy
       @group = Group.find(params[:id])
       notifications_ids =Notification.where(notifiable_type: "group",notifiable_id: @group.id).ids

       if @group.destroy
         Notification.where(id: notifications_ids ).destroy_all
       end
       redirect_to request.referer, notice: 'ユーザーを削除しました。'
    end
end
