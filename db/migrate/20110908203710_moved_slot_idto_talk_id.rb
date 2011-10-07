class MovedSlotIdtoTalkId < ActiveRecord::Migration
  def self.up
    remove_column :talks, :slot_id
    remove_column :talks, :locked
    add_column :slots, :talk_id, :integer
    add_column :slots, :locked, :boolean, :default => false
  end

  def self.down
    remove_column :slots, :talk_id
    remove_column :slots, :locked
    add_column :talks, :slot_id, :integer
    add_column :talks, :locked, :boolean
  end
end
