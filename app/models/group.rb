class Group < ApplicationRecord
  attr_accessor :user_id
  
  scope :dm, -> { where(group_name: nil) }
  scope :gm, -> { where.not(group_name: nil) }
  
  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy
  
  validates :group_name, presence: true
  
  after_create :add_first_entry
  
  private
  
  def add_first_entry
    if self.user_id.present?
      user = User.find(self.user_id)
      user.entries.create!(group_id: self.id)
    end
  end
end
