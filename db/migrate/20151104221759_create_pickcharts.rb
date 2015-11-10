class CreatePickcharts < ActiveRecord::Migration
  def change
    create_table :pickcharts do |t|
      t.integer :week
      t.string :vteam
      t.string :vt_rec
      t.string :hteam
      t.string :ht_rec
      t.string :gametime

      t.timestamps null: false
    end
  end
end
