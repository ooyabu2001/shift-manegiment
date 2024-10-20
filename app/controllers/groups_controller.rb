class GroupsController < ApplicationController
  def index
    @groups = Group.gm

  end

  def show
    @group = Group.find(params[:id])
    @entry = current_user.entries.find_or_initialize_by(group_id: @group.id)
    @message = current_user.messages.build(group_id: @group.id)
    @messages = @group.messages
    @users = User.where(id: @group.entries.pluck(:user_id))

  end

  def new
    @group = Group.new(user_id: current_user.id)
  end

  def create
    group = Group.create #グループ作成
    _current_entry = Entry.create(user_id: current_user.id, group_id: group.id )#ログインしているユーザーのレコード作成
    _another_entry = Entry.create(user_id: params[:entry][:user_id],group_id: group.id)#メッセージ相手のレコード作成
    redirect_to group_path(group)
  end
end
