class AddIncludeInGridToRoom < ActiveRecord::Migration
  def self.up
    add_column :rooms, :include_in_grid, :boolean, :default => true
  end

  def self.down
    remove_column :rooms, :include_in_grid
  end
end