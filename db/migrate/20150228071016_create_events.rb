class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :start_time
      t.references :user
      t.string :title, :category
      t.string :longitude
      t.string :latitude

      t.timestamps
    end
  end
end
