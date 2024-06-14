# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    # You should configure your model like this:
    # devise :omniauthable, omniauth_providers: [:twitter]

    def google_oauth2
      user = User.from_omniauth(auth)

      if user.present?
        sign_out_all_scopes
        flash[:success] = t "devise.omniauth_callbacks.success", kind: "Google"
        sign_in_and_redirect user, event: :authentication
      else
        flash[:alert] =
          t "devise.omniauth_callbacks.failure", kind: "Google", reason: "#{auth.info.email} is not authorized."
        redirect_to new_user_session_path
      end
    end

    protected

    def after_omniauth_failure_path_for(_scope)
      new_user_session_path
    end

    def after_sign_in_path_for(resource_or_scope)
      # The below should work, but session is lost. See https://github.com/plataformatec/devise/issues/1357
      # return_to = session[:return_to]
      # session[:return_to] = nil

      # Instead we pass return_to from ApplicationController#authenticate_user! to the button to POST login,
      # so we can redirect back to the original requested page here using return_to.
      # stored_location_for(resource_or_scope) is kept in case we add normal Devise login.
      return_to = request.env["omniauth.params"].try(:[], "return_to")
      stored_location_for(resource_or_scope) || return_to || root_path
    end

    private

    def auth
      @auth ||= request.env["omniauth.auth"]
    end

    # You should also create an action method in this controller like this:
    # def twitter
    # end

    # More info at:
    # https://github.com/heartcombo/devise#omniauth

    # GET|POST /resource/auth/twitter
    # def passthru
    #   super
    # end

    # GET|POST /users/auth/twitter/callback
    # def failure
    #   super
    # end

    # protected

    # The path used when OmniAuth fails
    # def after_omniauth_failure_path_for(scope)
    #   super(scope)
    # end
  end
end
