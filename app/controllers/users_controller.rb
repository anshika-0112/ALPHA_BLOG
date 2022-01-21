class UsersController < ApplicationController
    before_action :set_user, only:[:edit,:update,:show]

    def show
    end

    def index
        @users=User.all
    end

    def new
        @user=User.new
    end

    def edit
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

    def update
        if @user.update(user_params)
            flash[:notice]="User information updated successfully"
            redirect_to articles_path
        else
            render :edit, status: :unprocessable_entity
        end
    end

    private

    def user_params()
        params.require(:user).permit(:username,:email,:password)
    end

    def set_user
        @user=User.find(params[:id])
    end
end