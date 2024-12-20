class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

     validates :name, presence: true

  has_many :tasks, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :groups, through: :entries
  has_many :messages, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy

def self.guest
  user = User.find_or_initialize_by(email: "guest@example.com")#ゲスト専用Emailを探すか新しく作成
  user.password = "guestguest"
  user.name ="GUEST" #ユーザ名前を代入
  user.save
  return user
end
end