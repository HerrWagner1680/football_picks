class RemovePcIdFromStanding < ActiveRecord::Migration
  def change
    remove_column :standings, :pc_id, :string
  end
end
