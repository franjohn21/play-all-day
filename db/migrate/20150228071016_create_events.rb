class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :start_time
      t.references :user
      t.string :title, :category, :location_name
      t.string :longitude
      t.string :latitude
      t.integer :num_people
      t.string :img_url

      t.timestamps
    end
  end
end
