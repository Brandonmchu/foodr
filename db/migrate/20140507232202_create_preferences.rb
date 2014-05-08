class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.string :pref

      t.timestamps
    end
  end
end
