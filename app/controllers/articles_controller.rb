class ArticlesController < ApplicationController
    before_action :set_article, only:[:show,:update,:destroy,:edit]
    before_action :require_user, except:[:index,:show]
    before_action :require_same_user, only:[:edit,:destroy,:update]

    def show
    end

    def index
        @articles=Article.paginate(page: params[:page], per_page: 5)
    end

    def new
        @article=Article.new
    end

    def edit
    end

    def create
        @article=Article.new(article_params)
        @article.user= current_user
            if @article.save
                flash[:notice]="Article created successfully"
                redirect_to @article
            else
                render :new,status: :unprocessable_entity
            end
    end

    def update
            if @article.update(article_params)
                flash[:notice]="Article edited successfully"
                redirect_to @article
            else
                render :edit,status: :unprocessable_entity
            end
    end

    def destroy
        @article.destroy
        flash[:notice]="Article successfully Deleted"
        redirect_to articles_path,status: :see_other
    end

    private

    def set_article
        @article=Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title,:descrition,:author)
    end

    def require_same_user
        if current_user!=@article.user
            flash[:alert]="You can edit or delete your own article"
            redirect_to articles_path
        end
    end
end