class GroupsController < ApplicationController
  def index
    @groups = Group.gm
    #current_entries = current_user.entries
    #my_group_ids = [] #空の配列を作成
    #current_entries.each do |entry|
    # my_group_ids << entry.group.id  #複数のグループを配列を用いてグループとして格納する
    #end
    #@another_entries = Entry.where(group_id: my_group_ids).where.not(user_id: current_user.id)
  end

  def show
    @group = Group.find(params[:id])
    @entry = current_user.entries.find_or_initialize_by(group_id: @group.id)
    @message = current_user.messages.build(group_id: @group.id)
    @messages = @group.messages
    @users = User.where(id: @group.entries.pluck(:user_id))
    #@another_entry = @group.entries.where('user_id != ?', current_user.id)#メッセージ相手を探し取り出す
  end
  
  def new
    @group = Group.new(user_id: current_user.id)
  end

  def create
    group = Group.create #グループ作成
    current_entry = Entry.create(user_id: current_user.id, group_id: group.id )#ログインしているユーザーのレコード作成
    another_entry = Entry.create(user_id: params[:entry][:user_id],group_id: group.id)#メッセージ相手のレコード作成
    redirect_to group_path(group)
  end
end
