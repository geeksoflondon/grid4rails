class Timeslot < ActiveRecord::Base
  validates :end, :uniqueness => {:scope => :start}
end
