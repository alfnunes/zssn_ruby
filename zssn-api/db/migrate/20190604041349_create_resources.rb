class CreateResources < ActiveRecord::Migration[5.2]
  def change
    create_table :resources do |t|
      t.integer :point
      t.string :name
      t.timestamps
    end
  end
end