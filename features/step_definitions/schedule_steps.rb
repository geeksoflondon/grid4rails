Given /^there is an unscheduled talk$/ do
  @talk = Talk.new
end

Given /^there is an empty slot$/ do
  @slot = Slot.new
end

When /^I schedule the talk in the slot$/ do
  @slot.
end

When /^I submit the form$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the schedule should be displayed$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^my talk should be shown to occupy the slot I chose$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see a message confirming the successful scheduling of my talk$/ do
  pending # express the regexp above with the code you wish you had
end
