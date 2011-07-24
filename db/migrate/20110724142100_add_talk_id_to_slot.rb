class AddTalkIdToSlot < ActiveRecord::Migration
  def self.up
    add_column :slots, :talk_id, :integer
  end

  def self.down
    remove_column :slots, :talk_id, :integer
  end
end
