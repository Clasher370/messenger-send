class Destination < ApplicationRecord
  belongs_to :message

  # validates_presence_of :messenger, :user
end
