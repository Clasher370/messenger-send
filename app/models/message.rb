class Message < ApplicationRecord
  has_many :destinations, dependent: :destroy
  accepts_nested_attributes_for :destinations, reject_if: :destination_defined

  validates_presence_of :body, :destinations

  before_create :set_deliver_in

  validates_datetime :deliver_in, allow_nil: true

  private

  def set_deliver_in
    self.deliver_in ||= Time.now
  end

  def destination_defined(attr)
    Destination.where(message_id: Message.where(body: body).ids,
                      messenger: attr['messenger'],
                      nickname: attr['nickname']).any?
  end
end
