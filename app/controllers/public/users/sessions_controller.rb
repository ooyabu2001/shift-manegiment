class Public::Users::SessionsController < Devise::SessionsController
  def guest_sign_in
    user = User.guest #ユーザーにゲストユーザーを代入
    sign_in user # ゲストユーザーとしてログイン
    redirect_to users_mypage_url, notice: 'ゲストユーザとしてログインしました'
  end
end