class UsersController < ApplicationController
    # before_action :set_user, only:[:create]
    def new
        @user=User.new
    end

    def create
        @user=User.new(user_params)
        if @user.save
            flash[:notice]="User signed up successfully"
            redirect_to articles_path
        else
            render :new, status: :unprocessable_entity
        end
    end

    private
    def user_params()
        params.require(:user).permit(:username,:email,:password)
    end
end