class AddUserToStandings < ActiveRecord::Migration
  def change
    add_column :standings, :user_id, :integer
  end
end
