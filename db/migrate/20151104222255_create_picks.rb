class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.integer :pickchart_id
      t.string :user_pick
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
