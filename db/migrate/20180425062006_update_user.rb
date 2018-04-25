class UpdateUser < ActiveRecord::Migration[5.1]
  def change
  	remove_column :users, :username
  	add_column :users, :email, :string
  	add_column :users, :calendar_id, :string

  end
end
