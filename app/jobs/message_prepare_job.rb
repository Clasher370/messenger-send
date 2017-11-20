class MessagePrepareJob < ApplicationJob
  queue_as :high_priority

  def perform(message)
    message.destinations.each do |dest|
      MessageSendJob.set(wait_until: message.deliver_in)
                    .perform_later(dest)
    end
  end
end
