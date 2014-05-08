class AddUserIdToPreferences < ActiveRecord::Migration
  def change
    add_column :preferences, :user_id, :integer
  end
end
