require 'spec_helper'

describe Room do

  before(:each) do
      
    # Create a room
    @room = FactoryGirl.build(:room)
    
  end
  
  describe "#is_empty?(timeslot)" do
    # pending
  end
  
  describe "#slots_mixed_with_nonassignables" do
    # pending
  end
  
  describe ".by_short_code(short_code)" do
    # pending
  end
    
  describe "#slots" do
    
    before(:each) do
              
      # Create an empty collection to contain 
      # all control slots
      @control_slots = Array.new
                 
      # Create an empty collection to contain 
      # only the control slots assigned to this room
      @control_slots_assigned = Array.new
      
      # Create an empty collection to contain 
      # only the control slots NOT assigned to this room
      @control_slots_not_assigned = Array.new
            
      # Create several slots assigned to this room
      3.times do
        
        slot = FactoryGirl.build(:slot, :room => @room)
        
        # and add them to the collection
         @control_slots << slot 
         @control_slots_assigned << slot
         
      end
                           
      # Create a several slots not assigned to this room
      3.times do
        
        slot = FactoryGirl.build(:slot)
              
         # and add them to the collection
         @control_slots << slot
         @control_slots_not_assigned << slot
         
      end
       
    end
    
    it "includes all slots assigned to this room" do
            
      # Request only the slots assigned to this room
      slots = @room.slots
      
      # Check that the collection returned includes
      # all of the slots currently assigned to this room
      @control_slots_assigned.each do |slot| 
        slots.include?(slot).should eq(true)  
      end
            
    end

    it "excludes slots not assigned to this room" do
      
      # Request only the slots assigned to this room
      slots = @room.slots
      
      # Check that the collection returned does not include
      # any of the slots not currently assigned to this room
      @control_slots_not_assigned.each do |slot| 
        slots.include?(slot).should eq(false)  
      end
      
    end
    
  end
  
end