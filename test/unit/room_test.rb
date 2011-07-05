require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  def test_letter_conversion
    room = Room.new
    room.name = "Charing Cross"
    room.description = "A railway station, of course."
    room.save
    assert(room.letter_code.class == String)
  end
end
