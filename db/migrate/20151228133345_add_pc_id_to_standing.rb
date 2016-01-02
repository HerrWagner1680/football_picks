class AddPcIdToStanding < ActiveRecord::Migration
  def change
    add_column :standings, :pc_id, :string
  end
end
