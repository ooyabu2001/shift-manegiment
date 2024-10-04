class MessagesController < ApplicationController

  def create
    message = Message.new(message_params)
    message.user_id = current_user.id
    if message.save
      redirect_to group_path(message.group)
    else
      redirect_back(fallback_location: group_path)#一つ前の画面にとぶ
    end
  end

  def destroy
    message = Message.find(params[:id])
    message.destroy
    redirect_back(fallback_location: group_path)
  end

  private

  def message_params
      params.require(:message).permit(:group_id, :body)
  end
end
