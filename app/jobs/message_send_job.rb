class MessageSendJob < ApplicationJob
  queue_as :high_priority

  class NotSend < StandardError; end

  retry_on NotSend, wait: 5.second, attempts: 5, queue: :low_priority

  def perform(destination)
    if destination.deliver == 'yes'
      destination.update(status: 'ok')
    elsif executions == 5
      destination.update(status: 'fail')
    else
      raise NotSend, "Something go's wrong"
    end
  end
end
