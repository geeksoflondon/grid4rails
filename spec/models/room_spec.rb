require 'spec_helper'

describe Room do
  
  subject { FactoryGirl.build(:room) }
  it { should be_valid }
    
  describe "associations" do
    it { should have_many(:slots) }
  end
  
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:short_code) }
    it { should validate_presence_of(:capacity) }
    it { should_not allow_value(-1).for(:capacity) }
  end
  
  describe "#name" do
    
    it "has the correct name" do
      
      # Choose a name
      name = "Correctly Named Room"
      
      # Create a room with the chosen name
      room = FactoryGirl.build(:room, :name => name)
      
      # Check that the room has the name specified
      room.name.should eq(name)
      
    end    
  end
  
  describe "#description" do
    
    it "has the correct description" do
      
      # Describe the room
      description = "It's a beautiful room."
      
      # Create a room with the chosen description
      room = FactoryGirl.build(:room, :description => description)
      
      # Check that the room has the description specified
      room.description.should eq(description)
      
    end    
  end
  
  describe "#short_code" do
    
    it "has the correct short code" do
      
      # Choose a short code
      short_code = "SCO"
      
      # Create a room with the chosen short code
      room = FactoryGirl.build(:room, :short_code => short_code)
      
      # Check that the room has the short code specified
      room.short_code.should eq(short_code)
      
    end    
  end
  
  describe "#weighting" do
    pending
  end
  
  describe "#facilities" do
    
    it "has the expected facilities" do
      
      # Specify the facilities
      facilities = "Large TV, keyboard, mouse and magic wand."
      
      # Create a room with the specified facilities
      room = FactoryGirl.build(:room, :facilities => facilities)
      
      # Check that the room has the facilities specified
      room.facilities.should eq(facilities)
      
    end  
    
  end
  
  describe "#is_empty?(timeslot)" do    
    pending    
  end
  
  describe "#slots_mixed_with_nonassignables" do
    pending
  end
  
  describe ".by_short_code(short_code)" do   
    
    before(:each) do
      
      # Choose a short code
      @short_code = "SCO"
            
      # Create a generic room (so target room isn't first)
      FactoryGirl.create(:room)
      
      # Create a room with the chosen short code
      @room = FactoryGirl.create(:room, :short_code => @short_code)
      
      # Create another generic room (so target room isn't last)
      FactoryGirl.create(:room)
      
      
    end
    
    it "should retrieve a single room" do                          
      
      # Create an empty array to hold whatever's returned by the method call
      @result = Array.new

      # Request this room by its short code
      @result << Room.by_short_code(@short_code)
      
      # Check that a single room has been returned
      @result.count.should eq(1)
        
    end
    
    it "should retrieve the room expected" do                                    
    
      # Request this room by its short code
      @result  = Room.by_short_code(@short_code)
      
      # Check that a single room has been returned
      @result.id.should eq(@room.id)
        
    end
       
  end
    
  describe "#slots" do
    
    before(:each) do
      
      # Create a room
      @room = FactoryGirl.create(:room)
              
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
        
        slot = FactoryGirl.create(:slot, :room => @room)
        
        # and add them to the collection
         @control_slots << slot 
         @control_slots_assigned << slot
         
      end
                           
      # Create a several slots not assigned to this room
      4.times do
        
        slot = FactoryGirl.create(:slot)
              
         # and add them to the collection
         @control_slots << slot
         @control_slots_not_assigned << slot
         
      end
       
    end
    
    it "returns the expected number of slots" do
            
      # Request only the slots assigned to this room
      slots = @room.slots
      
      slots.count.should eq(3)
            
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