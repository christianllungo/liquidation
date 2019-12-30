class CreateUserscreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :password_digest, null: false
      t.string :session_token, null: false
      t.integer :phone_number, null: false
      t.string :email, null: false
    end

    add_index :users, :username
    add_index :users, :session_token, unique: true
    
    create_table :products do |t|
      t.string :name, null: false
      t.string :category, null: false
      t.decimal :price, null: false, :precision => 8, :scale => 2
      t.text :description, null: false
      t.integer :user_id, null: false
      t.timestamps
    end

    add_index :products, :user_id
  end
end
