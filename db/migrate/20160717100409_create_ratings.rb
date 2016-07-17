class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :user, null: false
      t.references :post, null: false
      t.integer :value, null: false

      t.timestamps null: false
    end

    add_index :ratings, [:user_id, :post_id], unique: true
  end
end
