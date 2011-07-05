class AddShortcodeAndWeightingToRoom < ActiveRecord::Migration
  def self.up
    add_column :rooms, :short_code, :string
    add_column :rooms, :weighting, :integer
  end

  def self.down
    remove_column :rooms, :weighting
    remove_column :rooms, :short_code
  end
end
