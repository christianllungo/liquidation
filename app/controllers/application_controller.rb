class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception

  # to be able to use helper method on views
  helper_method :current_user

  # saves the user object to a variable and saves session on cookie
  def login!(user)
    @current_user = user
    session[:session_token] = user.session_token
  end

  # returns the current user object or finds it by the session token stored
  # after login!(user) you can safely use current_user()
  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by(session_token: session[:session_token])
  end
end
