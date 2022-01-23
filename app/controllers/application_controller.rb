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

    def require_user
        if !logged_in?
            flash[:alert]="You must be logged in to perform that action"
            redirect_to login_path
        end
    end
end
