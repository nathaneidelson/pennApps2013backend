class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :token
      t.string :hook_url

      t.timestamps
    end
  end
end
