class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


def user_signed_in?
  session[:user_id].present?
end
helper_method :user_signed_in?

def current_user
  @current_user ||= User.find_by_id session[:user_id] if user_signed_in?
end
helper_method :current_user

def authenticate_user!
  if !user_signed_in?
    redirect_to new_session_path, notice: 'You must be signed in!'
  end
end
end
