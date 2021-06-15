class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :fetch_notifications

  # @@ global variable
  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :nickname, :bio])
    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :nickname, :bio, :avatar])
  end

  private

  def fetch_notifications
    if current_user
      @notifications = current_user.notifications
    end
  end
end
