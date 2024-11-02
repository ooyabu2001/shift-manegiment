class Public::FavoritesController < ApplicationController

  def create
    message= Message.find(params[:message_id])
    favorite = current_user.favorites.new(message_id: message.id)
    favorite.save
    redirect_to　group_messages_pathh(message.group, message)
  end

  def destroy
   message= Message.find(params[:message_id])
favorite = current_user.favorites.find_by(message_id: message.id)
   favorite.destroy
   redirect_to group_messages_path(message.group, message)

  end

end
