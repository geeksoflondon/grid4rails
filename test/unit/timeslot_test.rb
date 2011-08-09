require 'test_helper'

class TimeslotTest < ActiveSupport::TestCase
  test "load fixtures from file" do
    assert timeslots(:one).name == "Session 1"
    assert timeslots(:one).start < timeslots(:one).end
    assert timeslots(:one) != timeslots(:two)
    assert timeslots(:one).class == timeslots(:two).class
  end

  test "cannot create duplicate timeslots" do
    ts1 = Timeslot.new do |t|
      t.name  = "one"
      t.start = Date.parse("2011-07-22 14:00:00")
      t.end   = Date.parse("2011-07-22 14:30:00")
    end

    ts1.save
    assert ts1.errors.empty?

    ts2 = Timeslot.new do |t|
      t.name  = "two"
      t.start = Date.parse("2011-07-22 14:00:00")
      t.end   = Date.parse("2011-07-22 14:30:00")
    end

    assert ts2.save == false
    assert !(ts2.errors.empty?)
  end
  
  test "can get the current timeslot and the next timeslot" do
    ts1 = Timeslot.all.first
    ts2 = Timeslot.all.second
    
    Timecop.travel(ts1.start)
    
    assert Timeslot.now == ts1
    assert Timeslot.next == ts2
    
    Timecop.return()
    
  end
  
end
