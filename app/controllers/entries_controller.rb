class EntriesController < ApplicationController
  def create
    @entry = current_user.entries.find_or_initialize_by(entry_params)
    @group = @entry.group
    if @entry.save
      flash[:notice] = "参加しました"
      redirect_to group_path(@group)
    else
      @message = current_user.messages.build(group_id: @group.id)
      @messages = @group.messages
      @users = User.where(id: @group.entries.pluck(:user_id))
      flasn.now[:alert] = "失敗しました"
      render 'groups/show'
    end
  end
  
  def destroy
    @entry = Entry.find(params[:id])
    @group = @entry.group
    @entry.destroy
    redirect_to group_path(@group)
  end
  
  private
  
  def entry_params
    params.require(:entry).permit(:group_id)
  end
end
