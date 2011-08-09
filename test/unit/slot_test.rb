require 'test_helper'

class SlotTest < ActiveSupport::TestCase
  test "can get the current slots and the next slots" do
    
    now_ts = Timeslot.all.first
    next_ts = Timeslot.all.second
    
    #Start the day
    Timecop.travel(now_ts.start)
    
    
    assert Slot.now.first.timeslot_id == now_ts.id
    assert Slot.next.first.timeslot_id == next_ts.id
    
    Timecop.return()
    
  end
end
