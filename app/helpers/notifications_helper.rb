module NotificationsHelper

   def notification_message(notification)
    case notification.notifiable_type
    when "message"
      "#{notification.notifiable_id}さんから#{notification.notifiable_type}が届きました"
    end
   end
end
