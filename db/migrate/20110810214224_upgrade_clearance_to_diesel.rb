class UpgradeClearanceToDiesel < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      t.string :email
      t.string :encrypted_password, :limit => 128
      t.string :salt, :limit => 128
      t.string :confirmation_token, :limit => 128
      t.string :remember_token, :limit => 128

      t.remove :username
    end

    add_index :users, :email
    add_index :users, :remember_token
  end

  def self.down
    change_table(:users) do |t|
      t.remove :email,:encrypted_password,:salt,:confirmation_token,:remember_token
    end
  end
end
