class Group < ApplicationRecord
  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy
  
  validates :group_name, presence: true
end
