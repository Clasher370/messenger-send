class ApplicationController < ActionController::API
  include Knock::Authenticable

  before_action :authenticate_user

  rescue_from ActiveRecord::RecordInvalid do |e|
    json_response(e.message, :unprocessable_entity)
  end

  private

  def json_response(object = {}, status = :ok)
    render json: object, status: status
  end
end
