class RemoveGlobalFromSlot < ActiveRecord::Migration
  def self.up
    remove_column :slots, :global
  end

  def self.down
	add_column :slots, :global, :boolean, :default => false    
  end
end
