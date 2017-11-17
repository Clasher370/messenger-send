class MessagesController < ApplicationController
  def create
    message = Message.new(message_params)
    if message.save
      render json: {}, status: :ok
    else
      render json: message.errors.messages
    end
  end

  private

  def message_params
    params.permit(:body, :deliver_in, destinations_attributes: [:messenger, :user])
  end
end
