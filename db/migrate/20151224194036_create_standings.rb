class CreateStandings < ActiveRecord::Migration
  def change
    create_table :standings do |t|
      t.integer :wins
      t.integer :losses

      t.timestamps null: false
    end
  end
end
