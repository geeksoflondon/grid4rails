require 'spec_helper'

describe Talk do

  before(:each) do
      
    # Create a talk
    @talk = FactoryGirl.build(:talk)
    
  end
  
  describe "#is_unscheduled" do
    # pending
  end
  
  describe "#schedule(target_slot)" do
    # pending
  end
    
  describe ".unscheduled" do
    # pending
  end
    
  describe ".by_updated" do
    # pending
  end    

end