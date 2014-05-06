class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :yelp_id
      t.string :name
      t.integer :spice

      t.timestamps
    end
  end
end
