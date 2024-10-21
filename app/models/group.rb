class Group < ApplicationRecord
  attr_accessor :user_id

  #scope :dm, -> { where(group_name: nil) }
  #scope :gm, -> { where.not(group_name: nil) }

  has_many :entries, dependent: :destroy
   has_many :users, through: :entries
  has_many :messages, dependent: :destroy

  validates :group_name, presence: true
  validates :owner_id, presence: true

  after_create :add_first_entry

  private

  def joined_by?(user)
    group_users.exists?(user_id: user.id)  # ユーザーがグループに参加しているかを判定
  end
end
