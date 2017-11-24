class MessagesController < ApplicationController
  def create
    message = Message.create!(uniq_params)
    MessagePrepareJob.perform_later(message)
    json_response
  end

  private

  def uniq_params
    hash = permit_params.to_hash
    hash['destinations_attributes']&.uniq!
    hash
  end

  def permit_params
    params.permit(:body,
                  :deliver_in,
                  destinations_attributes: %i[messenger nickname])
  end
end
