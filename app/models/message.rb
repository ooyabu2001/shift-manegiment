class Message < ApplicationRecord
  attribute :receiver_id, :integer

  belongs_to :user
  belongs_to :group

  validates :body, presence: true

  before_validation :set_entries

  private

  def set_entries
    if self.group.nil?
      groups = Group.dm.joins(:entries)
                       .where('entries.user_id': [self.user_id, self.receiver_id])
      result_ids = groups.map {|o| [ o.id, o.entries.pluck(:user_id).sort ] }
      target_ids = [self.user_id, self.receiver_id].sort
      errors.add(:base, "同一IDには送信できません。") if self.user_id == self.receiver_id
      group_exist = result_ids.select { |o| o.last == target_ids }
      if group_exist.any?
        group_id = group_exist.first.first
        group = Group.find(group_id)
      else
        group = Group.new
        group.save(validate: false)
        group.entries.create!(user_id: self.user_id)
        group.entries.create!(user_id: self.receiver_id)
      end
      self.group_id = group.id
    end
    self
  end
end
