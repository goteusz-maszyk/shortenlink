class CreateShortenlink < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.string :org_link, unique: true
      t.string :shlink, unique: true
      t.references :user, index: true
      
      t.timestamps
    end
  end
end
