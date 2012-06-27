Given /^there is an unscheduled talk$/ do
  @talk = FactoryGirl.build(:talk)  
end

Given /^there is an empty slot$/ do
  @empty_slot = FactoryGirl.build(:slot)
  
  @slot = @empty_slot
  @slot.is_empty?.should == true
end

Given /^there is an occupied slot$/ do
  @occupied_slot = FactoryGirl.build(:slot)
  @occupied_slot.is_empty?.should == true
 
  @occupying_talk = FactoryGirl.build(:talk)
  @occupying_talk.is_unscheduled.should == true
  
  @occupying_talk.schedule(@occupied_slot)
  @occupied_slot.is_empty?.should == false
  @occupying_talk.is_unscheduled.should == false
  
  @slot = @occupied_slot
end

Given /^the talk in the occupied slot is not the talk I wish to schedule$/ do
  puts(@slot.talk)
end

When /^I schedule the talk in the empty slot$/ do
  @talk.schedule(@slot)
end

When /^I schedule the talk in the occupied slot$/ do
  @talk.schedule(@slot)
end

Then /^the talk should be unscheduled$/ do
  @talk.is_unscheduled.should == true
end

Then /^the talk should not be unscheduled$/ do
  @talk.is_unscheduled.should == false
end

Then /^the talk should be scheduled to occur in the slot$/ do
  @talk.slot.should == @slot
end

Then /^the talk should not be scheduled to occur in the slot$/ do
  @talk.slot.should_not == @slot
end

Then /^the original talk should still be scheduled$/ do
  @original_talk.is_scheduled.should == true
end

Then /^the original talk should still be scheduled to occur in the slot$/ do
  @original_talk.slot.should == @slot
end