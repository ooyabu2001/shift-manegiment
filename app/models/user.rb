class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

def self.guest
  find_or_create_by!(email: "guest@example.com")#ゲスト専用Emailを探すか新しく作成
  user.password = secureRandom.urlsafe_base64(6) #パスワードをランダムかつ６文字以上で作成
  user.name ="GUEST" #ユーザ名前を代入
  user.account_id = "guest000"
end
end