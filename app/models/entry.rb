class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates_uniqueness_of :group_id, scope: :user_id # 同じユーザーが同じグループに複数回参加しない
end
