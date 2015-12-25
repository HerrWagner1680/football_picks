class AddWinnerToPickcharts < ActiveRecord::Migration
  def change
    add_column :pickcharts, :winner, :string
  end
end
