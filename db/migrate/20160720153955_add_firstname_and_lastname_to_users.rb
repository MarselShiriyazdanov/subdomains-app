class AddFirstnameAndLastnameToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.remove :full_name
    end
  end
end
