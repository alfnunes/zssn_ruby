class CreateSurvivors < ActiveRecord::Migration[5.2]
  def change
    create_table :survivors do |t|
      t.string :name
      t.integer :age
      t.string :gender
      t.point :last_location
      t.boolean :infected
      t.integer :reported_infected_count, default: 0
      t.timestamps
    end
  end
end
