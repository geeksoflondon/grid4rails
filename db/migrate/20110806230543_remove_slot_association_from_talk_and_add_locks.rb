class RemoveSlotAssociationFromTalkAndAddLocks < ActiveRecord::Migration
  def self.up
    add_column :talks, :locked, :boolean, :default => false
    remove_column :slots, :talk_id
  end

  def self.down
    add_column :slots, :talk_id, :integer
    remove_column :talks, :locked
  end
end
