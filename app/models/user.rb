class User < ActiveRecord::Base
  validates_uniqueness_of :username, :on => :create, :message => "must be unique"
end
