class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name
      t.integer :population
      t.float :demographic_density
      t.float :area
      t.float :fleet
      t.float :idh
      t.float :gini
      t.float :health
      t.float :violence
      t.boolean :uber
      t.string :image

      t.timestamps null: false
    end
  end
end
