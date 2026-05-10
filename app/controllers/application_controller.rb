class ApplicationController < ActionController::API
  before_action :debug_warden
  def debug_warden
  Rails.logger.warn "=== WARDEN DEBUG ==="
  Rails.logger.warn "Authorization: #{request.headers['Authorization'].inspect}"
  Rails.logger.warn "Cookies: #{request.cookies.inspect}"
  Rails.logger.warn "current_user: #{current_user&.id}"
  Rails.logger.warn "==================="
  end
  include ActionController::MimeResponds
  respond_to :json

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])

    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name])
  end
end
