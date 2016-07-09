class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string   :name, null: false
      t.references :user

      t.timestamps null: false
    end

    add_index :companies, :name, unique: true
  end
end
