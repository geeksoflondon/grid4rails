require 'spec_helper'

describe Timeslot do
  
  subject { FactoryGirl.build(:timeslot) }
    it { should be_valid }
      
    describe "associations" do
      it { should have_many(:slots) }
    end
    
    describe "validations" do
      pending
    end
  

  before(:each) do
      
    # Create a timeslot
    @timeslot = FactoryGirl.build(:timeslot)
    
  end
  
  describe "#slot_by_room(room)" do
    
    it "returns a single slot" do
      pending
    end
    
    it "returns a slot belonging to this timeslot" do
      pending
    end
    
    it "returns a slot belonging to the room specified" do
      pending
    end
    
  end
  
  describe "#on_now?" do
    pending
  end  
    
  describe "#on_next?" do
    pending
  end  
  
  describe "#next" do
    pending
  end  
  
  describe "#prev" do
    pending
  end  
  
  describe "#duration_in_minutes" do
    pending
  end
  
  describe "#contains_empty_slot?" do
    pending
  end  
  
  describe "#global_talk" do
    pending
  end  
  
  describe "#has_global_talk" do
    pending
  end  
  
  describe "#slots_for_display(room, empty)" do
    pending
  end  
  
  describe ".generate!(session_no, num_timeslots, start_time, session_duration, break_duration)" do
    pending
  end  
  
  describe ".past" do
    pending
  end
      
  describe ".upcoming" do
    pending
  end
  
  describe ".on_now" do
    pending
  end      

  describe ".on_next" do
    pending
  end  

  describe ".today" do
    pending
  end    
  
  describe ".first_day" do
    pending
  end  
  
  describe ".by_date(date_in)" do
    pending
  end  
  
  describe ".by_day(name)" do
    pending
  end  
  
  describe ".dates" do
    pending
  end    
  
  describe ".start_date" do
    pending
  end    
  
  describe ".end_date" do
    pending
  end    
  
  describe ".auto_date" do
    pending
  end  
    
  describe ".non_assignables" do
    pending
  end   
  
end