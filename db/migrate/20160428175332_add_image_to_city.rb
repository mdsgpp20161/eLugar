class AddImageToCity < ActiveRecord::Migration
  def self.up
    add_column :cities, :image, :string
  end
end
