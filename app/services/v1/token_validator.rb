class Services::V1::TokenValidator
  def validate_user(token)
    decoded_token = validate_token(token)
    return unless decoded_token && decoded_token[:id]
    User.find(decoded_token[:id])
  end

  def validate_token(token)
    JWT.decode(token, secret).first.symbolize_keys
  rescue JWT::ExpiredSignature
    Rails.logger.warn('Authentication signature has expired')
    nil
  rescue JWT::DecodeError
    Rails.logger.warn("Authentication token: #{token} could not be verified")
    nil
  end

  private

  def secret
    Rails.application.secrets[:secret_key_base]
  end
end
