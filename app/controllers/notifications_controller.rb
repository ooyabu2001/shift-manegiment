class NotificationsController < ApplicationController
   before_action :authenticate_user!

   def update
    notification = current_user.notifications.find(params[:id])
    notification.update(read: true)
    # 通知の種類のパスの生成
    case notification.notifiable_type
    when "message"
      redirect_to message_path(notification.notifiable)
    else
      redirect_to user_path(notification.notifiable.user)
    end
   end
end

