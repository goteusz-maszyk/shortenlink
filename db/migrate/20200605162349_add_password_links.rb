class AddPasswordLinks < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :pro, :boolean, default: false
    add_column :links, :encrypted_password, :string
  end
end
