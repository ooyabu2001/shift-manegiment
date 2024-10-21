class EntriesController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    @group_user = current_user.entry.new(group_id: group.id)
    @group = @entry.group
    if @entry.save
      flash[:notice] = "参加しました"
      redirect_to group_path(@group)
    else
      @message = current_user.messages.build(group_id: @group.id)
      @messages = @group.messages
      @group_user = current_user.group_users.new(group_id: group.id)
      flasn.now[:alert] = "失敗しました"
      render 'groups/show'
    end
  end

  def destroy
    @group = Group.find(params[:group_id])
    @entry= current_user.entry.find_by(group_id: group.id)
    @entry.destroy
    redirect_to group_path(@group)
  end

  private

  #def entry_params
  #  params.require(:entry).permit(:group_id)
 # end
end
