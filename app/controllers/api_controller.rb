class ApiController < ApplicationController

  protect_from_forgery with: :null_session

  rescue_from ActionController::ParameterMissing do |exception|
    render json: { messages: ["Parameter #{exception.param} is required"] },
           status: :unprocessable_entity
  end

end