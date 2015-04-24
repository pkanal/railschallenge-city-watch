class ApplicationController < ActionController::Base
  rescue_from ActionController::UnpermittedParameters do |error|
    render json: { message: error.message }, status: 422
  end
end
