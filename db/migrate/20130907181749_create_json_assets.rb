class CreateJsonAssets < ActiveRecord::Migration
  def change
    create_table :json_assets do |t|
      t.string :name
      t.text :content
      t.integer :client_id

      t.timestamps
    end
  end
end
