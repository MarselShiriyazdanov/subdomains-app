class AddCompanyIdAndOwnerFlagToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.references :company, null: false
      t.boolean :owner, default: false
    end

    remove_column :companies, :user_id
  end
end
