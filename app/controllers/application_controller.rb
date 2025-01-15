class ApplicationController < ActionController::Base
  include Pagy::Backend

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate_user!
  helper_method :current_user

  def authenticate_user!
    return unless current_user.nil?

    redirect_to new_session_path
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def self.authenticate_roles(role, except: [])
    before_action except: except do
      redirect_to root_path unless current_user&.role == role.to_s
    end
  end
end
