class MoveTalkSlotIds < ActiveRecord::Migration
  def self.up
    add_column :slots, :talk_id, :integer
    add_column :slots, :locked, :boolean, :default => false
    add_column :slots, :global, :boolean, :default => false
    remove_column :talks, :slot_id
    remove_column :talks, :locked
  end

  def self.down
    add_column :talks, :slot_id, :integer
    add_column :talks, :locked, :boolean, :default => false
    remove_column :slots, :talk_id
    remove_column :slots, :locked
    remove_column :slots, :global
  end
end