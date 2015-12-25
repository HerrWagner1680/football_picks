class AddWeekToStandings < ActiveRecord::Migration
  def change
    add_column :standings, :week, :integer
  end
end
