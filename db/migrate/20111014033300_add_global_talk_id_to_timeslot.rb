class AddGlobalTalkIdToTimeslot < ActiveRecord::Migration
  def self.up
    add_column :timeslots, :global_talk_id, :integer
  end

  def self.down
    remove column :timeslots, :global_talk_id, :integer
  end
end
