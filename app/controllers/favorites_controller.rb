class FavoritesController < ApplicationController

  def create
    message= Message.find(params[:messages_id])
    favorite = current_user.favorites.new(message_id: message.id)
    favorite.save
    redirect_to group_message_path(message.group, message)
  end

  def destroy
   message= Message.find(params[:messages_id])
favorite = current_user.favorites.find_by(message_id: message.id)
   favorite.destroy
   redirect_to group_message_path(message.group, message)

  end

end
