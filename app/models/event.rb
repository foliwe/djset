class Event < ApplicationRecord
validates :name, presence: true
validates :venue, presence: true
validates :time, presence: true
validates :address, presence: true
end
