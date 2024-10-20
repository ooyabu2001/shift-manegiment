class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy ]

  def index
    @users = User.all

  end

   def mypage
       @users = User.new
   end


  def show
    @users=User.all
    @user = User.find(params[:id])
    groups = Group.joins(:entries)
                  .where(group_name: nil,
                         'entries.user_id': [current_user.id, @user.id])
    result_ids = groups.map {|o| [o.id, o.entries.pluck(:user_id)] }
    group_exist = result_ids.select { |o| o.last == [@user.id, current_user.id] || o.last == [current_user.id, @user.id] }
    @group = Group.find_by_id(group_exist.first.first) if group_exist.any?
    @message = @user.messages.build(receiver_id: @user.id)
    @messages = @group&.messages || []

   
  end

  def create
   
    if @user.save
     log_in @user
     redirect_to user_url(@user), "notice:ようこそ, shiftcalenderへ！"
    else
        render :top
    end
  end
end


  def update
    if @user.update(user_params)
    redirect_to user_url(@user), notice: "ユーザーアカウントの更新が完了しました。"
    else
        render :edit
    end
  end


  def destroy
    @user.destroy
      redirect_to users_url, notice: "ユーザーアカウントの削除が完了しました。"
  end



private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email)
    end









