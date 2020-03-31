class CreateShortenlink < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.string :org_link, unique: true
      t.string :shlink, unique: true
      t.bigint :user_id
      
      t.timestamps
    end
  end
end
