class ArticlesController < ApplicationController
    before_action :set_article, only:[:show,:update,:destroy,:edit]

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
end