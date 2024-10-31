class  Public::UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy ]

  def index
    @user = User.new
    @users = User.all
    @users = @users.where('name LIKE ?', "%#{params[:user_name]}%") if params[:user_name].present?
    @users = @users.joins(:entry_groups).where('groups.group_name LIKE ?', "%#{params[:group_name]}%").distinct if params[:group_name].present?
  end

   def mypage
      @users=User.new
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
    @groups = @user.entry_groups


  end

  def create
    @user = User.new(user_params)
   if @user.save
    redirect_to users_path, notice: 'ユーザーを作成しました'
   else
    render :index
   end

    if @user.save
     log_in @user
     redirect_to user_url(@user), "notice:ようこそ, shiftcalenderへ！"
    else
        render :top
    end
  end

  def edit
      @user = User.find(params[:id])
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

end







