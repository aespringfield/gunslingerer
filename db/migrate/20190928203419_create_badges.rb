class CreateBadges < ActiveRecord::Migration[5.2]
  def change
    create_table :badges do |t|
      t.integer :badge_template_id
      t.datetime :issued_at
      t.references :gunslinger, foreign_key: true

      t.timestamps
    end
  end
end
