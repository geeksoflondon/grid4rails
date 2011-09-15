class AddFacilitiesToRoom < ActiveRecord::Migration
  def self.up
    add_column :rooms, :facilities, :string
  end

  def self.down
    add_column :rooms, :facilities, :string
  end
end