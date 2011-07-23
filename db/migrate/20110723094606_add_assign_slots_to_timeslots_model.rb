class AddAssignSlotsToTimeslotsModel < ActiveRecord::Migration
  def self.up
    add_column :timeslots, :assign_slots, :boolean, :default => true
    add_column :timeslots, :description, :string
  end

  def self.down
    remove_column :timeslots, :description
    remove_column :timeslots, :assign_slots
  end
end
