class Destination < ApplicationRecord
  belongs_to :message

  validates_presence_of :messenger, :nickname
  validates_inclusion_of :messenger, in: %w( telegram viber whatsapp )
end
