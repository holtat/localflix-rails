module AuthenticationHelper
  def authenticate(user)
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(user)
  end

  private

  def secret
    Rails.application.secrets[:secret_key_base]
  end

  def payload(user)
    { id: user.id }
  end
end
