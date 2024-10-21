class ChangeOwnerIdToIntegerInGroups < ActiveRecord::Migration[6.1]
  def change
     change_column :groups, :owner_id, :integer
  end
end
