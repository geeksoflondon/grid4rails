require 'spec_helper'

describe Talk do
  
  subject { FactoryGirl.build(:talk) }
  it { should be_valid }
    
  describe "associations" do
    it { should have_one(:slot) }
  end
  
  describe "validations" do
    pending
  end
  
  describe "#is_unscheduled" do
    
    it "is an unscheduled talk" do
      FactoryGirl.build(:talk, :unscheduled).is_unscheduled.should eq(true)
    end
    
    it "is a scheduled talk" do      
      FactoryGirl.build(:talk, :scheduled).is_unscheduled.should eq(false)    
    end
    
  end
  
  describe "#schedule(target_slot)" do
    
    before(:each) do
          
      # Create an empty slot
      @empty_slot = FactoryGirl.build(:slot, :unoccupied)
        
      # Create an occupied slot            
      @occupied_slots = Array.new
      2.times do
        @occupied_slots << FactoryGirl.build(:slot, :occupied)  
      end
              
    end
    
    it "assigned an unscheduled talk to an empty slot" do
      
      # The slot is empty
      @empty_slot.is_empty?.should eq(true)
      
      # Create an unscheduled talk
      talk = FactoryGirl.build(:talk, :unscheduled)
      talk.is_unscheduled.should eq(true)
      
      # Attempt to schedule the talk in the empty slot
      talk.schedule(@empty_slot)
      
      # The talk should no longer be unscheduled
      talk.is_unscheduled.should eq(false)
      
    end
    
    it "reasigned an already scheduled talk to a different (but empty) slot" do    
      
      # Retrieve an occupied slot from our prepared collection
      occupied_slot = @occupied_slots.first
      occupied_slot.is_empty?.should eq(false)
      
      # Retrieve the talk from the occupied slot
      talk = occupied_slot.talk
      talk.is_unscheduled.should eq(false)
      talk.slot.should eq(occupied_slot)
            
      # Attempt to schedule the already scheduled talk in the empty slot
      talk.schedule(@empty_slot)
            
      # The talk should still be scheduled
      talk.is_unscheduled.should eq(false)
      
      # The talk should be scheduled in the (originally) empty slot
      talk.slot.should eq(@empty_slot)
                
    end
          
    it "failed to assign an unscheduled talk to an already occupied slot" do
      
      # Create an unscheduled talk
      talk = FactoryGirl.build(:talk, :unscheduled)
      talk.is_unscheduled.should eq(true)
      
      # Retrieve an occupied slot from our prepared collection
      occupied_slot = @occupied_slots.first
      occupied_slot.is_empty?.should eq(false)
      
      # Make a note of which talk is scheduled in the occupied slot
      occupying_talk = occupied_slot.talk
      occupied_slot.talk_id.should eq(occupying_talk.id)     
            
      # Attempt to schedule the unscheduled talk in the occupied slot
      talk.schedule(occupied_slot)
            
      # The talk should still be unscheduled
      talk.is_unscheduled.should eq(true)
      
      # Check that the occupied slot still contains its original talk
      occupied_slot.talk_id.should eq(occupying_talk.id)  
      
    end
    
    it "failed to assign an already scheduled talk to an already occupied slot" do
      
      # Retrieve an occupied slot from our prepared collection
      occupied_slot = @occupied_slots.first
      occupied_slot.is_empty?.should eq(false)
      
      # Retrieve the talk from the occupied slot
      talk = occupied_slot.talk
      talk.is_unscheduled.should eq(false)
      talk.slot.should eq(occupied_slot)
                  
      # Retrieve another (different) occupied slot
      another_occupied_slot = @occupied_slots.second
      another_occupied_slot.is_empty?.should eq(false)
      
      # Make a note of the talk scheduled in the second occupied slot
      another_talk = another_occupied_slot.talk
      another_talk.slot.id.should eq(another_occupied_slot.id)     
      
      # Attempt to schedule the already scheduled talk in another (different) occupied slot
      talk.schedule(another_occupied_slot)
      
      # The talk should still be scheduled in its original slot
      talk.is_unscheduled.should eq(false)
      talk.slot.should eq(occupied_slot)    
      
      # The other occupied slot should still contain its original talk
      another_occupied_slot.is_empty?.should eq(false)
      another_occupied_slot.talk.id.should eq(another_talk.id)       
      
    end
            
  end
    
  describe ".unscheduled" do
    
    before(:each) do          
              
      # Create an empty collection to contain 
      # all control talks
      @control_talks = Array.new
                 
      # Create an empty collection to contain 
      # only the control talks that are scheduled
      @control_talks_scheduled = Array.new
      
      # Create an empty collection to contain 
      # only the control talks that are NOT scheduled
      @control_talks_not_scheduled = Array.new                 
      
      # Create several scheduled talks
      3.times do
        
        talk = FactoryGirl.create(:talk, :scheduled)
        
        # and add them to the collection
        @control_talks << talk
        @control_talks_scheduled << talk
         
      end
                           
      # Create a several unscheduled talks
      4.times do
        
        talk = FactoryGirl.create(:talk, :unscheduled)
              
         # and add them to the collection
         @control_talks << talk
         @control_talks_not_scheduled << talk
         
      end
       
    end
    
    it "returns the expected number of talks" do
            
      # Request only the scheduled talks
      talks = Talk.unscheduled
      
      talks.count.should eq(4)
            
    end
    
    it "includes all talks that are unscheduled" do
            
      # Request only the unscheduled talks
      talks = Talk.unscheduled     
      
      # Check that the collection returned includes
      # all of the talks currently NOT scheduled
      @control_talks_not_scheduled.each do |talk| 
        talks.include?(talk).should eq(true)  
      end
            
    end

    it "excludes scheduled talks" do
      
      # Request only the unscheduled talks
      talks = Talk.unscheduled
      
      # Check that the collection returned does not include
      # any of the talks that are currently scheduled
      @control_talks_scheduled.each do |talk| 
        talks.include?(talk).should eq(false)  
      end
      
    end       
    
  end
    
  describe ".by_updated" do
    pending
  end    

end