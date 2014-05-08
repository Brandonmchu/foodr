class AddLikeToPreferences < ActiveRecord::Migration
  def change
    add_column :preferences, :like, :boolean
  end
end
