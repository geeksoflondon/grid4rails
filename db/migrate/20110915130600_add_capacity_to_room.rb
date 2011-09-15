class AddCapacityToRoom < ActiveRecord::Migration
  def self.up
    add_column :rooms, :capacity, :integer
  end

  def self.down
    add_column :rooms, :capacity, :integer
  end
end