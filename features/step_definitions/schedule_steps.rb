Given /^there is an unscheduled talk$/ do
  @talk = Talk.new
end

Given /^there is an empty slot$/ do
  @slot = Slot.new
end

# Given /^I am on the (.+) page$/ do |page_name|
#  eval("visit #{page_name}_path")
# end

When /^I schedule the talk in the slot$/ do
  @slot.talk_id = @talk.id
end

# When /^I submit the form$/ do
#  page.evaluate_script("document.forms[0].submit()")
# end

Then /^the talk should not be unscheduled$/ do
  !@talk.is_unscheduled
end

Then /^the talk should be scheduled to occur in the slot$/ do
  @talk.slot == @slot.id
end

# Then /^the schedule should be displayed$/ do
#  pending # express the regexp above with the code you wish you had
# end

# Then /^my talk should be shown to occupy the slot I chose$/ do
#   pending # express the regexp above with the code you wish you had
# end

# Then /^I should see a message confirming the successful scheduling of my talk$/ do
#   pending # express the regexp above with the code you wish you had
# end