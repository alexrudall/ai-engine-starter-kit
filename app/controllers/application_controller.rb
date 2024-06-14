class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  protected

  def authenticate_user!
    return if current_user

    # We pass this to the POST login button, so we can redirect back to the original requested page
    # in omniauth_callbacks_controller.rb.
    session[:return_to] = request.fullpath

    super
  end
end
