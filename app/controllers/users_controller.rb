class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user =User.find(params[:id])

     @current_entry = Entry.where(user_id: current_user.id)# ログインしているユーザー（current_user）に紐付いたエントリーを取得
     @another_entry = Entry.where(user_id: @user.id)
     unless @user.id == current_user.id
     @current_entry.each do |current|
     @another_entry.each do |another|
       if current.group_id == another.group_id #現在のユーザーともう一人のユーザーが同じ部屋にいるかどうかを確認
       @is_group =true
       @group_id =current.group_id
       end
      end
     end
      unless @is_group
        @group = group.new
        @entry = Entry.new
      end
     end
  end
end


