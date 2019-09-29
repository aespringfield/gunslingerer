class ChangeTypeOfBadgeTemplateId < ActiveRecord::Migration[5.2]
  def change
    change_column :badges, :badge_template_id, :string
  end
end
