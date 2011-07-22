require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  test "cannot create duplicate rooms with same shortcode" do
    rm1 = Room.new do |r|
      r.name        = "Paddington"
      r.description = "The big room upstairs."
      r.short_code  = "pad"
    end

    rm1.save
    assert rm1.errors.empty?

    rm2 = Room.new do |r|
      r.name        = "Paddington Bear"
      r.description = "A completely different room."
      r.short_code  = "pad"
    end
    
    rm2.save
    assert rm2.errors.include?(:short_code)
  end
  
  test "short codes must be of the right format" do
    rm = Room.new(:name => "Charing Cross", :short_code => "Charing Cross")
    rm.save
    assert rm.errors.include?(:short_code)

    rm = Room.new(:name => "Charing Cross", :short_code => "chx*>")
    rm.save
    assert rm.errors.include?(:short_code)

    rm = Room.new(:name => "Charing Cross", :short_code => "~~~OMG~~~")
    rm.save
    assert rm.errors.include?(:short_code)

    rm = Room.new(:name => "Charing Cross", :short_code => "&&$?173489lkjsdf")
    rm.save
    assert rm.errors.include?(:short_code)

    rm = Room.new(:name => "Waterloo East", :short_code => "wae")
    rm.save
    assert !(rm.errors.include?(:short_code))
  end
end
