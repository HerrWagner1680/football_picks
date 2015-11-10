class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.boolean :admin
      t.string :email
      t.string :user_name
      t.string :password
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
