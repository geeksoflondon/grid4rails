class AddingIndexes < ActiveRecord::Migration
  def self.up
    add_index :slots, :room_id
    add_index :slots, :talk_id
    add_index :slots, :timeslot_id
    add_index :slots, :locked
    add_index :slots, :global

    add_index :slots, :id
    add_index :rooms, :id
    add_index :talks, :id
    add_index :timeslots, :id
  end

  def self.down
  end
end
