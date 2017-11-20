class MessagesController < ApplicationController
  def create
    message = Message.create!(message_params)
    MessagePrepareJob.perform_later(message)
    render json: {}, status: :ok
  end

  private

  def message_params
    params.permit(:body,
                  :deliver_in,
                  destinations_attributes: %i[messenger nickname])
  end
end
