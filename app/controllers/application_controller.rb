class ApplicationController < ActionController::API
  include Knock::Authenticable

  before_action :authenticate_user

  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: e.message, status: :unprocessable_entity
  end
end
