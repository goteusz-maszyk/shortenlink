class AddTitleToLinks < ActiveRecord::Migration[6.0]
  def change
    add_column :links, :title, :string
  end
end
