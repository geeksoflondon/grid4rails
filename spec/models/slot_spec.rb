require 'spec_helper'

describe Slot do

  before(:each) do
      
    # Create a slot
    @slot = FactoryGirl.build(:slot)
    
  end
  
  describe "#start" do
    pending
  end
  
  describe "#end" do
    pending
  end
  
  describe "#is_empty?" do
    
    it "does not have a talk assigned to it" do
    
      # Create an empty slot
      slot = FactoryGirl.build(:slot)
        
      # The slot be empty
      slot.is_empty?.should eq(true)
    
    end
    
    it "does have a talk assigned to it" do
    
      # Create an occupied slot
      slot = FactoryGirl.build(:occupied_slot)         
        
      # The slot should not be empty
      slot.is_empty?.should eq(false)
    
    end
    
  end
    
  describe ".generate!" do
    pending
  end
    
  describe ".find_empty" do
    pending
  end
  
  describe ".find_occupied" do
    pending
  end

  describe ".by_timeslot(timeslot)" do
    pending
  end  
  
  describe ".on_now" do
    pending
  end
  
  describe ".on_next" do
    pending
  end  
    

end