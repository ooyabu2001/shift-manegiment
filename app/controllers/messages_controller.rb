class MessagesController < ApplicationController

  def create
    @message = current_user.messages.build(message_params)
    if @message.save
      flash[:norice] = "メッセージを送信しました。"
      redirect_to user_path(@message.receiver_id)
    else
      flash.now[:alert] = "メッセージの送信に失敗しました。"
      @user = User.find(@message.receiver_id)
      @group = @message.group
      @messages = @group&.messages || []
      render 'users/show'
    end
  end

  def destroy
    message = Message.find(params[:id])
    message.destroy
    redirect_back(fallback_location: group_path)
  end

  private

  def message_params
      params.require(:message).permit(:group_id, :body, :user_id, :receiver_id)
  end
end
