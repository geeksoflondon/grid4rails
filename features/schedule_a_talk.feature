Feature: Schedule a talk
		
	Scenario: Chosen slot is free
	
		Given there is an unscheduled talk
		And there is an empty slot
		When I schedule the talk in the empty slot
		Then the talk should not be unscheduled
		And the talk should be scheduled to occur in the slot		
		
		
	Scenario: Chosen slot is not free
	
		Given there is an unscheduled talk
		And there is an empty slot
		And there is an occupied slot	
		And the talk in the occupied slot is not the talk I wish to schedule
		When I schedule the talk in the occupied slot		
		Then the talk should be unscheduled
		And the talk should not be scheduled to occur in the slot
		And the original talk should still be scheduled		
		And the original talk should still be scheduled to occur in the slot