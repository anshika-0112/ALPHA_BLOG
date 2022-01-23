class ApplicationController < ActionController::Base
    helper_method :current_user,:logged_in?

    def logged_in?
        !!current_user
    end

    def current_user
        if session[:user_id]
            @current_user ||=User.find(session[:user_id])
        end
    end
end
