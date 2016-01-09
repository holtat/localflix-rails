class ApplicationController < ActionController::API
  include ActionController::Serialization
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :render_unauthorized

  def authenticate
    current_user || render_unauthorized
  end

  def current_user
    unless @current_user
      authenticate_with_http_token do |token|
        @current_user = token_validator.validate_user(token)
      end
    end
    @current_user
  end

  def render_unauthorized(message = 'Unauthorized')
    render text: message, status: :unauthorized
  end

  private

  def token_validator
    Services::V1::TokenValidator.new
  end
end
