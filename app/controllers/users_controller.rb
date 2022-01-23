class UsersController < ApplicationController
    before_action :set_user, only:[:edit,:update,:show]
    def new
        @user=User.new
    end

    def edit
    end

    def index
        @users=User.paginate(page: params[:page],per_page:5)
    end

    def show
        @articles=@user.articles.paginate(page: params[:page],per_page:5)
    end

    def create
        @user=User.new(user_params)
        if @user.save
            flash[:notice]="User signed up successfully"
            session[:user_id]=@user.id
            redirect_to articles_path
        else
            render :new, status: :unprocessable_entity
        end
    end

    def update
        if @user.update(user_params)
            flash[:notice]="User information updated successfully"
            redirect_to @user
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