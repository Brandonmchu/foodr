class AddCategoriesToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :categories, :string
    add_column :restaurants, :rating, :float
    add_column :restaurants, :review_count, :integer
    add_column :restaurants, :url, :string
    add_column :restaurants, :phone, :string
    add_column :restaurants, :distance, :integer
  end
end
