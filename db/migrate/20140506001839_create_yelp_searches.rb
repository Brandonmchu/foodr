class CreateYelpSearches < ActiveRecord::Migration
  def change
    create_table :yelp_searches do |t|
      t.string :cond_one
      t.string :cond_two

      t.timestamps
    end
  end
end
