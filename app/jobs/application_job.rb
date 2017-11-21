class ApplicationJob < ActiveJob::Base
  if Rails.env.test?
    self.queue_adapter = :async
  end
end
