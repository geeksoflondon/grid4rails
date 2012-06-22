Feature: Schedule a talk
		
	Scenario: Chosen slot is free
	
		Given there is an unscheduled talk
		And there is an empty slot
		When I schedule the talk in the slot
		And I submit the form
		Then the schedule should be displayed
		And my talk should be shown to occupy the slot I chose
		And I should see a message confirming the successful scheduling of my talk