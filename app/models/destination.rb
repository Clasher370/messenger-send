class Destination < ApplicationRecord
  belongs_to :message

  validates_presence_of :messenger, :nickname
  validates_inclusion_of :messenger, in: %w( telegram viber whatsapp )

  def deliver
    sleep 3
    puts "deliver message #{ self.message.body } to #{ self.messenger } for #{ self.nickname }"
  end
end
