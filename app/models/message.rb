class Message < ApplicationRecord
  has_many :destinations
  accepts_nested_attributes_for :destinations

  validates_presence_of :body, :destinations

  before_create :set_deliver_in

  validates_datetime :deliver_in

  private

  def set_deliver_in
    self.deliver_in ||= Time.now
  end
end
