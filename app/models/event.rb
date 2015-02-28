class Event < ActiveRecord::Base

  belongs_to :creator, :class_name => 'User'
  has_many :user_events
  has_many :users, :through => :user_events


  
end
