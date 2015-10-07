class Schedule < ActiveRecord::Base
  belongs_to :day
  belongs_to :dish
end
