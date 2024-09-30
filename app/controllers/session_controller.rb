def guest_sign_in
  user = User.guest #ユーザーにゲストユーザーを代入
  sign_user user # ゲストユーザーとしてログイン
  redirect_to root_path, notice: 'ゲストユーザとしてログインしました'
end 