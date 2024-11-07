class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy, :show]

  def new
    @group = Group.new(user_id: current_user.id)
  end

def index
    @group = Group.new(user_id: current_user.id)
    @groups = Group.all

end

  def show

    @users = @group.users  #@groupに入っているユーザーのみ格納
    @entry = Entry.find_by(user_id: current_user.id, group_id: @group.id) || Entry.new(user_id: current_user.id, group_id: @group.id)
    @message = current_user.messages.build(group_id: @group.id)
    @messages = @group.messages
    @owner_user = User.find(@group.owner_id) #グループオーナーを見つけて格納

  end

def create
    @group = Group.new(group_params)#グループ作成
    @group.owner_id = current_user.id

    #byebug
  if @group.save
    redirect_to group_path(@group),notice: "You have created group successfully."
  else
    render 'index'
  end
end

def update
    if @group.update(group_params)
      redirect_to groups_path, notice: "You have updated group successfully."
    else
      render 'edit'
    end
end

private

  def group_params
    params.require(:group).permit(:group_name, :owner_id, :group)
  end

  def ensure_correct_user #グループオーナーかどうかを判断する
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end
end