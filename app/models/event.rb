class Event < ApplicationRecord
validates :name, presence: true
validates :venue, presence: true
validates :start_time, presence: true
validates :end_time, presence: true
validates :address, presence: true
end
