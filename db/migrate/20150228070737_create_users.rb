class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, :username, :password_digest, :fb_id

      t.timestamps
    end
  end
end
