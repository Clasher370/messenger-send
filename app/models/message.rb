class Message < ApplicationRecord
  has_many :destinations
  accepts_nested_attributes_for :destinations

  validates_presence_of :body
end
