class RemoveIssuedAtColumnFromBadge < ActiveRecord::Migration[5.2]
  def change
    remove_column :badges, :issued_at
  end
end
