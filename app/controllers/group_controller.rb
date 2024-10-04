class GroupController < ApplicationController
  def index
    current_entries = current_user.entries
    my_group_ids = [] #空の配列を作成
    current_entries.each do |entry|
     my_group_ids << entry.group.id  #複数のグループを配列を用いてグループとして格納する
  　end
   @another_entries = Entry.where(group_id: my_group_ids).where.not(user_id: current_user.id)
  end


  def show
  @group = Group.find(params[:id])
  @message = Message.new
  @another_entry = @room.entries.find_by('user_id != ?', current_user.id)#メッセージ相手を探し取り出す
  end

  def create
    group = Group.create #グループ作成
    current_entry = Entry.create(user_id: current_user.id, group_id: group.id )#ログインしているユーザーのレコード作成
    another_entry = Entry.create(user_id: params[:entry][:user_id],group_id: group.id)#メッセージ相手のレコード作成
    redirect_to group_path(group)
  end
  end
end
