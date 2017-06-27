class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  private

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def log_in(user)
    session[:session_token] = user.reset_session_token
  end

  def log_out
    current_user.reset_session_token
    session[:session_token] = nil
  end

  def require_logged_in
    redirect_to subs_url unless logged_in?
  end

  # def require_logged_out
  #   redirect_to posts_url if logged_in?
  # end

  # def require_moderator(sub)
  #   #unless the current_user.id == moderator_id
  # end
end
