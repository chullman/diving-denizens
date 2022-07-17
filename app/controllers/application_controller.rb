class ApplicationController < ActionController::Base

    protect_from_forgery with: :exception

    # With reference to https://github.com/heartcombo/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address (viewed 12/07/2022)
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :find_current_user_address

    protected

    def configure_permitted_parameters

        devise_parameter_sanitizer.permit(:sign_up) do |user|
            user.permit(:email, :username, :password, :password_confirmation)
        end

        devise_parameter_sanitizer.permit(:account_update) do |user|
            user.permit(:email, :username, :password, :password_confirmation)
        end
    end

    def find_current_user_address
        if user_signed_in?
            @address = Address.find_by(user_id: current_user.id)
        end
    end

end
