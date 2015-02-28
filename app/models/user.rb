class User < ActiveRecord::Base
  has_secure_password
  has_many :events_created, class_name: "Event"

  has_many :user_events 
  has_many :events, :through => :user_events
end
