class ArticlesController < ApplicationController
    before_action :set_article, only:[:show,:update,:destroy,:edit]

    def show
    end

    def index
        @articles=Article.all
    end

    def new
        @article=Article.new
    end

    def edit
    end

    def create
        @article=Article.new(article_params)
        respond_to do |format|
            if @article.save
                format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
                format.json { render :show, status: :ok, location: @article }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @article.errors, status: :unprocessable_entity }
            end
        end
    end

    def update
        
        respond_to do |format|
            if @article.update(article_params)
                format.html { redirect_to article_url(@article), notice: "Article was successfully edited." }
                format.json { render :show, status: :ok, location: @article }
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.json { render json: @article.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @article.destroy
        flash[:notice]="Article successfully Deleted"
        redirect_to articles_path
    end

    private

    def set_article
        @article=Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title,:descrition,:author)
    end
end