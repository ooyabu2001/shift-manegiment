class Favorite < ApplicationRecord

  belongs_to :user
  belongs_to :message
   has_one :notification, as: :notifiable, dependent: :destroy

    after_create do
    create_notification(user_id: message.user_id)
    end

   validates :user_id, uniqueness: {scope: :message_id}
end
