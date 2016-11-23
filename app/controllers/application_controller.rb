class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :test

protected
  def test
    if current_user
      'application'
    else
      false
    end
  end
end
