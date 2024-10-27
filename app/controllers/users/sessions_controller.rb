class Public::Users::SessionsController < Devise::SessionsController
  def guest_sign_in
    user = User.guest #ユーザーにゲストユーザーを代入
    sign_in user # ゲストユーザーとしてログイン
    redirect_to root_path, notice: 'ゲストユーザとしてログインしました'
  end
end

