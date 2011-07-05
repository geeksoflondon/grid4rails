class Room < ActiveRecord::Base
  validates_uniqueness_of :short_code, :on => :create, :message => "must be unique"
  validates_format_of :short_code, :with => /^[A-Za-z0-9]{1,5}$/, :on => :create, :message => "is not of the correct format. It must be between one and five letters and numbers without spaces or symbols."
end
